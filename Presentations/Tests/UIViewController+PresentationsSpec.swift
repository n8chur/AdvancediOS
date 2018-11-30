import Quick
import Nimble
import ReactiveSwift
import Result
import ReactiveExtensions

@testable import Presentations

class UIViewControllerPresentationsSpec: QuickSpec {
    override func spec() {

        describe("DismissablePresentationContext.addCancelBarButtonItem(to:)") {
            it("should add a cancel button to the navigation item with the dismiss action") {
                let viewController = UIViewController()
                let presentedViewController = UINavigationController(rootViewController: viewController)

                var animatedValue: Bool?

                let presentation = DismissablePresentation(
                    presentedViewController: presentedViewController,
                    present: { (_, _) in return SignalProducer.empty },
                    dismiss: { (_, animated) -> SignalProducer<Never, NoError> in
                        return SignalProducer<Bool, NoError> { () -> Bool in
                                animatedValue = animated
                                return animated
                            }
                            .ignoreValues()
                    },
                    didDismiss: Signal.empty)
                let context = DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)

                context.addCancelBarButtonItem(to: viewController)

                guard let cancelButton = viewController.navigationItem.leftBarButtonItem else {
                    fail("cancelButton is not set.")
                    return
                }

                guard let action = cancelButton.reactive.pressed else {
                    fail("cancelButton's action is not set.")
                    return
                }

                // The button's action should be disabled until presentation completes.
                expect(action.isEnabled.value).to(beFalse())

                presentation.present.apply(context.presentAnimated).start()

                expect(action.isEnabled.value).to(beTrue())

                action.execute(cancelButton)

                expect(animatedValue).toEventually(beFalse())
            }
        }

    }
}
