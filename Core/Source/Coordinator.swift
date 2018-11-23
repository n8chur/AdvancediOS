import ReactiveSwift
import Result

public protocol Coordinator: class {
    associatedtype ViewModel
    associatedtype StartError: Swift.Error

    /// Starts presenting the view modle provided by the input.
    ///
    /// The signal completes when the presentation finishes.
    var start: Action<ViewModel, (), StartError> { get }
}
