import UIKit
import ReactiveSwift
import Result
import Presentations

extension DismissablePresentation {

    static func stub() -> DismissablePresentation {
        let viewController = UIViewController()
        return DismissablePresentation(
            presentedViewController: viewController,
            present: { (_, _)  in
                return SignalProducer<Never, NoError>.empty
            },
            dismiss: { (_, _) in
                return SignalProducer<Never, NoError>.empty
            },
            didDismiss: Signal<(), NoError>.empty)
    }

}
