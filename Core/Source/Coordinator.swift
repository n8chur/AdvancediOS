public protocol Coordinator {

    associatedtype ViewModel

    func start(_ viewModel: ViewModel, completion: (() -> Void)?)

}
