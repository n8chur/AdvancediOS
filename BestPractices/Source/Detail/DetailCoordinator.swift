import UIKit
import Core
import ReactiveSwift
import Result

class DetailCoordinator: Coordinator {

    typealias ViewModel = DetailViewModel
    typealias StartError = DetailPresentError

    let navigationController: UINavigationController

    /// This property will be nil until the start action has been executed.
    private weak var viewController: DetailViewController?

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] viewModel in
        return SignalProducer<DetailViewController, NoError> { DetailViewController(viewModel: viewModel) }
            .flatMap(.merge) { viewController -> SignalProducer<DetailViewController, ActionError<NoError>> in
                guard let strongSelf = self else {
                    fatalError()
                }

                // Keep a reference to the view controller so that it can be used in our presntation callbacks.
                strongSelf.viewController = viewController

                viewModel.selectionPresenter = strongSelf

                // Make the signal last until the view controller is removed from the navigation stack.
                //
                // This ensures that the coordinator will be alive while the view controller is in the navigation stack
                // since it is retained for the duration of the start command (see detailViewPresentation(in:of:)).
                //
                // This also ensures that the start action will be disabled while this view controller is already in the
                // navigation stack since the Action will still be executing.
                let didMoveToNilParent = viewController.reactive.didMoveToNilParent
                    .producer
                    .take(first: 1)

                return strongSelf.navigationController.reactive.pushViewController.apply((viewController, true))
                    .then(didMoveToNilParent.promoteError(ActionError<NoError>.self))
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
                    // This keeps the coordinator alive while the presentation is still active to ensure it can handle
                    // any presentation callbacks.
                    .untilDisposal(retain: coordinator)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}
