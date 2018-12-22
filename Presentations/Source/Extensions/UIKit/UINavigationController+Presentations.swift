import UIKit
import RxSwift

public extension UINavigationController {

    public func makePushPresentation(of viewController: UIViewController) -> DismissablePresentation {
        let present: DismissablePresentation.MakePresent = { [weak self] (viewController, animated) in
            guard let self = self else { fatalError() }

            return self.rx.pushViewController.execute((viewController, animated))
                .catchError { _ in return Observable<Never>.empty() }
                .ignoreElements()
        }

        let dismiss: DismissablePresentation.MakeDismiss = { [weak self] (viewController, animated) in
            guard let self = self else { fatalError() }

            return self.rx.popViewController.execute((viewController, animated))
                .catchError { _ in return Observable<Never>.empty() }
                .ignoreElements()
        }

        let didDismiss = viewController.rx.didMoveToNilParent
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
            .takeUntil(rx.deallocated)
            .subscribe()

        return presentation
    }

}
