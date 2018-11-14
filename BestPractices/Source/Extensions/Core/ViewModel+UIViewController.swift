import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

extension UIViewController {

    /// Returns a signal producer that sends true when the view has appeared and sends true when the view has
    /// disappeared.
    ///
    /// Consumers can supply a starting value (whether the reciever is currently "appeared") if the view has already
    /// appeared when this function has been called.
    ///
    /// - Parameter startingValue: The value to send first in the returned signal.
    func isAppearedProducer(startingValue: Bool = false) -> SignalProducer<Bool, NoError> {
        let trueOnAppearance = reactive
            .trigger(for: #selector(UIViewController.viewWillAppear(_:)))
            .map { _ in return true }
            .producer

        let falseOnDisappearance = reactive
            .trigger(for: #selector(UIViewController.viewDidDisappear(_:)))
            .map { _ in return false }
            .producer

        return SignalProducer
            .merge([
                trueOnAppearance,
                falseOnDisappearance,
            ])
            .prefix(value: startingValue)
    }

}
