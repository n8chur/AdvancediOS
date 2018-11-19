import ReactiveSwift
import Result

public protocol Coordinator: class {

    associatedtype ViewModel

    func start(viewModel: ViewModel, completion: (() -> Void)?)

}

public extension Coordinator {

    public func makeStart(_ viewModel: ViewModel) -> SignalProducer<ViewModel, NoError> {
        return SignalProducer { [weak self] (observer, _) in
            guard let strongSelf = self else {
                fatalError()
            }

            strongSelf.start(viewModel: viewModel, completion: {
                observer.send(value: viewModel)
                observer.sendCompleted()
            })
        }
    }

}
