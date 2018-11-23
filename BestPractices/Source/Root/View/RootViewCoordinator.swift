import UIKit
import Core
import ReactiveSwift
import Result

class RootViewCoordinator: Coordinator {

    typealias ViewModel = RootViewModel
    typealias StartError = RootViewPresentError

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private(set) lazy var start = Action<ViewModel, (), StartError> { viewModel in
        let setup = SignalProducer<RootViewController, NoError> { [weak self] () -> RootViewController in
            guard let strongSelf = self else {
                fatalError()
            }

            viewModel.detailPresenter = strongSelf

            let viewController = RootViewController(viewModel: viewModel)
            strongSelf.navigationController.viewControllers = [ viewController ]

            return viewController
        }

        return setup
            .flatMap(.merge) { [weak self] viewController -> SignalProducer<RootViewController, NoError> in
                let didMoveToNilParent = viewController.reactive.didMoveToNilParent.producer
                    .take(first: 1)
                    .ignoreValues()

                return SignalProducer<RootViewController, NoError>.never
                    .take(until: didMoveToNilParent)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}

extension RootViewCoordinator: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError> {
        return DetailCoordinator.detailPresentation(in: navigationController, of: viewModel)
    }

}

extension RootViewCoordinator {

    static func rootViewPresentation(in navigationController: UINavigationController, of viewModel: RootViewModel) -> SignalProducer<(), RootViewPresentationError> {
        return SignalProducer<RootViewCoordinator, NoError> { RootViewCoordinator(navigationController: navigationController) }
            .flatMap(.merge) { coordinator in
                return coordinator.start.apply(viewModel)
                    .untilDisposal(retain: coordinator)
            }
            .mapError { _ in return .unknown }
    }
}
