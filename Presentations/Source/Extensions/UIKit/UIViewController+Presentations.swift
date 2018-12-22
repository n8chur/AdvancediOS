import UIKit
import RxCocoa
import RxSwift
import Action

public extension UIViewController {

    public func makeModalPresentation(of viewController: UIViewController) -> DismissablePresentation {
        let present: DismissablePresentation.MakePresent = { [weak self] (viewController, animated) in
            guard let self = self else { fatalError() }

            return self.rx.present.execute((viewController, animated))
                .catchError { _ in return Observable<Never>.empty() }
                .ignoreElements()
        }

        let dismiss: DismissablePresentation.MakeDismiss = { (viewController, animated) in
            return viewController.rx.dismiss.execute(animated)
                .catchError { _ in return Observable<Never>.empty() }
                .ignoreElements()
        }

        let didDismiss = viewController.rx.didDismiss()
            .map { _ in return () }
            .asObservable()

        let presentation = DismissablePresentation(
            presentedViewController: viewController,
            present: present,
            dismiss: dismiss,
            didDismiss: didDismiss)

        // Retain the presentation for its lifecycle.
        _ = presentation.didDismiss
            .untilDisposal(retain: presentation)
            .takeUntil(viewController.rx.deallocated)
            .takeUntil(self.rx.deallocated)
            .subscribe()

        return presentation
    }

}

public extension DismissablePresentation {

    /// Sets the left navigation item to be a cancel button that executes the dismiss action.
    ///
    /// - Parameter viewController: The view controller to add the navigation item to.
    /// - Parameter animated: Whether the dismissal should be animated.
    public func addCancelBarButtonItem(to viewController: UIViewController, animated: Bool) {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        cancelButton.rx.bind(to: dismiss, input: animated)
        viewController.navigationItem.leftBarButtonItem = cancelButton
    }

}
