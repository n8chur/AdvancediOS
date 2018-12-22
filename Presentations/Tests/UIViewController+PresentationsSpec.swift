import Quick
import Nimble
import RxSwift
import UIKit
import RxExtensions
import Action
import RxBlocking
import Foundation

@testable import Presentations

class UIViewControllerPresentationsSpec: QuickSpec {
    override func spec() {

        describe("DismissablePresentation.addCancelBarButtonItem(to:)") {
            it("should add a cancel button to the navigation item with the dismiss action") {
                let viewController = UIViewController()
                let presentedViewController = UINavigationController(rootViewController: viewController)

                var animatedValue: Bool?

                let presentation = DismissablePresentation(
                    presentedViewController: presentedViewController,
                    present: { (_, _) in return Completable.empty() },
                    dismiss: { (_, animated) -> Completable in
                        return Observable<Bool>.create { observer in
                                animatedValue = animated
                                observer.onCompleted()
                                return Disposables.create()
                            }
                            .ignoreElements()
                    },
                    didDismiss: Observable<()>.empty())

                presentation.addCancelBarButtonItem(to: viewController, animated: false)

                guard let cancelButton = viewController.navigationItem.leftBarButtonItem else {
                    fail("cancelButton is not set.")
                    return
                }

                // The button's action should be disabled until presentation completes.
                expect(cancelButton.isEnabled).to(beFalse())

                _ = presentation.present.execute(false).subscribe()

                expect(cancelButton.isEnabled).to(equal(true))

                // Simulate a button press.
                _ = cancelButton.target?.perform(cancelButton.action)

                expect(animatedValue).toEventually(beFalse())
            }
        }

    }
}
