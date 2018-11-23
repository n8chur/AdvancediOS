import UIKit
import Core
import ReactiveSwift
import Result

class RootViewCoordinator: Coordinator {

    typealias ViewModel = RootViewModel
    typealias StartError = RootViewPresentError

    private weak var navigationController: UINavigationController?

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] viewModel in
        let setup = SignalProducer<RootViewController, NoError> { () -> RootViewController in
            guard
                let strongSelf = self,
                let navigationController = strongSelf.navigationController else {
                    fatalError()
            }

            viewModel.detailPresenter = strongSelf

            let viewController = RootViewController(viewModel: viewModel)
            navigationController.viewControllers = [ viewController ]

            return viewController
        }

        return setup
            .flatMap(.merge) { viewController -> SignalProducer<RootViewController, NoError> in
                // Make the signal last until the view controller is removed from the navigation stack.
                //
                // This ensures that the coordinator will be alive while the view controller is in the navigation stack
                // since it is retained for the duration of the start command (see rootViewPresentation(in:of:)).
                //
                // This also ensures that the start action will be disabled while this view controller is already in the
                // navigation stack since the Action will still be executing.
                let didMoveToNilParent = viewController.reactive.didMoveToNilParent.producer
                    .take(first: 1)
                    .ignoreValues()

                return SignalProducer<RootViewController, NoError>.never
                    .take(until: didMoveToNilParent)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension RootViewCoordinator: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError> {
        guard let navigationController = self.navigationController else {
            fatalError()
        }

        return DetailCoordinator.detailPresentation(in: navigationController, of: viewModel)
    }

}

extension RootViewCoordinator {

    static func rootViewPresentation(in navigationController: UINavigationController, of viewModel: RootViewModel) -> SignalProducer<(), RootViewPresentationError> {
        return SignalProducer<RootViewCoordinator, NoError> { RootViewCoordinator(navigationController: navigationController) }
            .flatMap(.merge) { coordinator in
                return coordinator.start.apply(viewModel)
                    // This keeps the coordinator alive while the presentation is still active to ensure it can handle
                    // any presentation callbacks.
                    .untilDisposal(retain: coordinator)
            }
            .mapError { _ in return .unknown }
    }
}
