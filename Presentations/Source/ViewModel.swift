import RxSwift
import RxCocoa

public protocol ViewModel {
    /// Indicates whether the view model is currently active.
    ///
    /// This value should be set by the associated view controller to indicate that it is visible and should be doing
    /// active work.
    var isActive: BehaviorRelay<Bool> { get }
}

/// A view model that has a result.
///
/// This might be a view model that backs a modal flow that takes some input for example.
public protocol ResultViewModel: ViewModel {
    associatedtype Result

    var result: Observable<Result> { get }
}
