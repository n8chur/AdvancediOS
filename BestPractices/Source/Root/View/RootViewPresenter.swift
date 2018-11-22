import ReactiveSwift
import Result
import Core

enum RootViewPresentError: Error {
    case unknown
}

protocol RootViewPresentingViewModel: class {

    var rootViewPresenter: RootViewPresenter? { get set }

    var presentRootView: Action<(), (), RootViewPresentError> { get }

}

enum RootViewPresentationError: Error {
    case unknown
}

protocol RootViewPresenter: class {

    func rootViewPresentation(of viewModel: RootViewModel) -> SignalProducer<(), RootViewPresentationError>

}
