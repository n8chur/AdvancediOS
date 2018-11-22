import ReactiveSwift
import Result
import Core

enum RootNavigationPresentError: Error {
    case unknown
}

protocol RootNavigationPresentingViewModel: class {

    var rootNavigationPresenter: RootNavigationPresenter? { get set }

    var presentRootNavigation: Action<(), (), RootNavigationPresentError> { get }

}

enum RootNavigationPresentationError: Error {
    case unknown
}

protocol RootNavigationPresenter: class {

    func rootNavigationPresentation(of navigationModel: RootNavigationModel) -> SignalProducer<(), RootNavigationPresentationError>

}
