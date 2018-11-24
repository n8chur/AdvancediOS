import UIKit
import ReactiveSwift
import Result

/// A dismissable presentation (e.g. navigation push, modal presentation, etc.).
///
/// Presentations are single use. To present a view a second time a new instance must be created.
public class DismissablePresentation<ViewController: UIViewController> {

    public typealias PresentedViewController = ViewController
    public typealias MakePresent = (_ presentedViewController: ViewController, _ animated: Bool) -> SignalProducer<Never, NoError>
    public typealias MakeDismiss = (_ presentedViewController: ViewController, _ animated: Bool) -> SignalProducer<Never, NoError>

    public let viewController: ViewController

    /// The action that begins executing the producer returned from the present producer (provided by the MakePresent
    /// closure at intialization time). The action's execution signal completes when the signal producer's signal
    /// completes.
    public let present: Action<Bool, Never, NoError>

    /// The action that begins executing the producer returned from the dismiss producer (provided by the MakeDismiss
    /// closure at intialization time). The action's execution signal completes when the signal producer's signal
    /// completes.
    ///
    /// This action will be disabled while the view controller is presented.
    public let dismiss: Action<Bool, Never, NoError>

    /// Sends () and then completes when the view controller dismisses (either through the the dismiss action or a value
    /// is sent along the didDismiss signal provided at intialization).
    ///
    /// This action will be disabled while the
    public let didDismiss: Signal<(), NoError>

    /// - Parameter viewController: The view controller being presented.
    /// - Parameter present: A closure that returns a signal producer that will be created and started when the present
    ///             action is executed. This signal producer should present the associated view controller.
    /// - Parameter dismiss: A closure that returns a signal producer that will be created and started when the dismiss
    ///             action is executed. This signal producer should dismiss the associated view controller.
    /// - Parameter didDismiss: Should send a value and then complete when the view controller did dismiss. In the case
    ///             of a view controller being presented in a navigation controller, this may be a signal that sends ()
    ///             when the view controller's parent becomes nil.
    public init(presentedViewController viewController: ViewController, present: @escaping MakePresent, dismiss: @escaping MakeDismiss, didDismiss: Signal<(), NoError>) {
        self.viewController = viewController

        let isPresented = MutableProperty<Bool>(false)
        let canPresent = MutableProperty<Bool>(true)
        canPresent <~ isPresented.signal.negate()

        self.present = Action<Bool, Never, NoError>(enabledIf: canPresent, execute: { animated -> SignalProducer<Never, NoError> in
            return present(viewController, animated)
        })

        self.dismiss = Action<Bool, Never, NoError>(enabledIf: isPresented, execute: { animated -> SignalProducer<Never, NoError> in
            return dismiss(viewController, animated)
        })

        self.didDismiss = Signal
            .merge([
                self.dismiss.completed,
                didDismiss,
            ])
            .take(first: 1)

        let trueDuringPresentation = self.present.isExecuting.signal
            .filter { $0 }
            .map { _ in return true }

        let falseAfterDismissal = self.didDismiss.map { false }

        isPresented <~ Signal.merge([
            trueDuringPresentation,
            falseAfterDismissal
        ])
    }

}
