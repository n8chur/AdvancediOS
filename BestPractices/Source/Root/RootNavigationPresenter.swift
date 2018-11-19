import ReactiveSwift
import Result
import Core

protocol RootNavigationPresentingViewModel: class {

    var presenter: RootNavigationPresenter? { get set }

    var presentRootNavigation: Action<(), RootNavigationModel, NoError> { get }

}

protocol RootNavigationPresenter: class {

    func presentRootNavigation(_ viewModel: RootNavigationModel) -> SignalProducer<RootNavigationModel, NoError>

}
