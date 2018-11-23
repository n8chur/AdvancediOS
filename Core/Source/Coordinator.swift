import ReactiveSwift
import Result

/// Coordinates presentation of a view model.
public protocol Coordinator: class {
    associatedtype ViewModel
    associatedtype StartError: Swift.Error

    /// Starts presenting the ViewModel provided by the input.
    ///
    /// The signal should complete when the presented view is no longer presented (e.g. dismissed/popped).
    var start: Action<ViewModel, (), StartError> { get }
}
