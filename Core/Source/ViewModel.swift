import ReactiveSwift

public protocol ViewModel {
    /// Indicates whether the view model is currently active.
    ///
    /// This value should be set by the associated view controller to indicate that it is visible and should be doing
    /// active work.
    var isActive: MutableProperty<Bool> { get }
}
