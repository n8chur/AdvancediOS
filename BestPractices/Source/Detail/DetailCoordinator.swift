import UIKit
import Core
import ReactiveSwift
import Result

class DetailCoordinator: Coordinator {

    typealias ViewModel = DetailViewModel
    typealias StartError = DetailPresentError

    let navigationController: UINavigationController

    private var viewController: DetailViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] viewModel in
        return SignalProducer<DetailViewController, NoError> { DetailViewController(viewModel: viewModel) }
            .flatMap(.merge) { [weak self] viewController -> SignalProducer<DetailViewController, ActionError<NoError>> in
                guard let strongSelf = self else {
                    fatalError()
                }

                strongSelf.viewController = viewController

                viewModel.selectionPresenter = strongSelf

                let didMoveToNilParent = viewController.reactive
                    .didMoveToNilParent
                    .take(first: 1)
                    .producer
                    .promoteError(ActionError<NoError>.self)

                return strongSelf.navigationController.reactive.pushViewController.apply((viewController, true))
                    .then(didMoveToNilParent)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}

extension DetailCoordinator: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<(), SelectionPresentationError> {
        guard let viewController = self.viewController else {
            fatalError()
        }

        return SelectionCoordinator.selectionPresentation(over: viewController, for: viewModel)
    }

}

extension DetailCoordinator {

    static func detailPresentation(in navigationController: UINavigationController, of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError> {
        return SignalProducer<DetailCoordinator, NoError> { DetailCoordinator(navigationController: navigationController) }
            .flatMap(.merge) { coordinator in
                return coordinator.start.apply(viewModel)
                    .untilDisposal(retain: coordinator)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}
