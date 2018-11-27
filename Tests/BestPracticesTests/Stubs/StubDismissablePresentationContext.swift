import UIKit
import ReactiveSwift
import Result
import Core

extension DismissablePresentationContext {

    static func stub() -> DismissablePresentationContext {
        let viewController = UIViewController()
        let presentation = DismissablePresentation(
            presentedViewController: viewController,
            present: { (_, _)  in
                return SignalProducer<Never, NoError>.empty
            },
            dismiss: { (_, _) in
                return SignalProducer<Never, NoError>.empty
            },
            didDismiss: Signal<(), NoError>.empty)
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
    }

}
