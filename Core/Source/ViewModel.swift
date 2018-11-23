import ReactiveSwift

public protocol ViewModel {
    var isActive: MutableProperty<Bool> { get }
}
