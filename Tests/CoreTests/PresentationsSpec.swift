import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

class PresentationsSpec: QuickSpec {
    override func spec() {

        describe("DismissablePresentation") {
            context("present") {
                it("should call the present closure with the appropriate values when executed") {
                    let viewController = UIViewController()

                    var presentClosureCallCount = 0
                    var presentClosureViewController: UIViewController?
                    var presentClosureAnimated: Bool?
                    let (presentSignal, presentObserver) = Signal<Never, NoError>.pipe()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (viewController, animated) in
                            presentClosureCallCount += 1
                            presentClosureViewController = viewController
                            presentClosureAnimated = animated

                            return presentSignal.producer
                        },
                        dismiss: { (_, _) in return SignalProducer<Never, NoError>.empty },
                        didDismiss: Signal<(), NoError>.empty)

                    expect(presentClosureCallCount).to(equal(0))
                    expect(presentClosureViewController).to(beNil())
                    expect(presentClosureAnimated).to(beNil())

                    let animated = true
                    presentation.present.apply(animated).start()
                    presentObserver.sendCompleted()

                    expect(presentClosureCallCount).to(equal(1))
                    expect(presentClosureViewController).to(equal(viewController))
                    expect(presentClosureAnimated).to(equal(animated))
                }

                it("should be disabled when the present command is executed") {
                    let viewController = UIViewController()

                    let (presentSignal, presentObserver) = Signal<Never, NoError>.pipe()
                    let (dismissSignal, dismissObserver) = Signal<Never, NoError>.pipe()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return presentSignal.producer },
                        dismiss: { (_, _) in return dismissSignal.producer },
                        didDismiss: Signal<(), NoError>.empty)

                    expect(presentation.present.isEnabled.value).to(beTrue())

                    presentation.present.apply(true).start()

                    expect(presentation.present.isEnabled.value).to(beFalse())

                    presentObserver.sendCompleted()

                    expect(presentation.present.isEnabled.value).to(beFalse())

                    presentation.dismiss.apply(true).start()

                    expect(presentation.present.isEnabled.value).to(beFalse())

                    dismissObserver.sendCompleted()

                    expect(presentation.present.isEnabled.value).to(beTrue())
                }
            }

            context("dismiss") {
                it("should call the dismiss closure with the appropriate values when executed") {
                    let viewController = UIViewController()

                    var dismissClosureCallCount = 0
                    var dismissClosureViewController: UIViewController?
                    var dismissClosureAnimated: Bool?
                    let (dismissSignal, dismissObserver) = Signal<Never, NoError>.pipe()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return SignalProducer<Never, NoError>.empty },
                        dismiss: { (viewController, animated) in
                            dismissClosureCallCount += 1
                            dismissClosureViewController = viewController
                            dismissClosureAnimated = animated

                            return dismissSignal.producer
                        },
                        didDismiss: Signal<(), NoError>.empty)

                    expect(dismissClosureCallCount).to(equal(0))
                    expect(dismissClosureViewController).to(beNil())
                    expect(dismissClosureAnimated).to(beNil())

                    let animated = true
                    presentation.present.apply(animated).start()

                    presentation.dismiss.apply(animated).start()
                    dismissObserver.sendCompleted()

                    expect(dismissClosureCallCount).to(equal(1))
                    expect(dismissClosureViewController).to(equal(viewController))
                    expect(dismissClosureAnimated).to(equal(animated))
                }

                it("should be disabled after the dismiss action finishes executing") {
                    let viewController = UIViewController()

                    let (presentSignal, presentObserver) = Signal<Never, NoError>.pipe()
                    let (dismissSignal, dismissObserver) = Signal<Never, NoError>.pipe()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return presentSignal.producer },
                        dismiss: { (_, _) in return dismissSignal.producer },
                        didDismiss: Signal<(), NoError>.empty)

                    expect(presentation.dismiss.isEnabled.value).to(beFalse())

                    presentation.present.apply(true).start()

                    expect(presentation.dismiss.isEnabled.value).to(beFalse())

                    presentObserver.sendCompleted()

                    expect(presentation.dismiss.isEnabled.value).to(beTrue())

                    presentation.dismiss.apply(true).start()

                    expect(presentation.dismiss.isEnabled.value).to(beFalse())

                    dismissObserver.sendCompleted()

                    expect(presentation.dismiss.isEnabled.value).to(beFalse())
                }

                it("should be disabled after the didDismiss signal sends a value") {
                    let viewController = UIViewController()

                    let (didDismiss, didDismissObserver) = Signal<(), NoError>.pipe()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return SignalProducer<Never, NoError>.empty },
                        dismiss: { (_, _) in return SignalProducer<Never, NoError>.empty },
                        didDismiss: didDismiss)

                    presentation.present.apply(true).start()

                    expect(presentation.dismiss.isEnabled.value).to(beTrue())

                    didDismissObserver.send(value: ())

                    expect(presentation.dismiss.isEnabled.value).to(beFalse())
                }
            }
        }

    }
}
