import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class RootNavigationCoordinator: Coordinator {

    typealias ViewModel = RootNavigationModel

    private var navigationController: RootNavigationController?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start(viewModel: RootNavigationModel, completion: (() -> Void)? = nil) {
        viewModel.rootViewModel.detailPresenter = self

        let navigationController = RootNavigationController(navigationModel: viewModel)
        self.navigationController = navigationController

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        completion?()
    }

}

extension RootNavigationCoordinator: DetailPresenter {

    func presentDetails(_ viewModel: DetailViewModel) -> SignalProducer<DetailViewModel, NoError> {
        guard let navigationController = self.navigationController else {
            fatalError()
        }

        viewModel.selectionPresenter = self

        let viewController = DetailViewController(viewModel: viewModel)

        let didMoveToNilParent = viewController.reactive.didMoveToNilParent.take(first: 1)

        // Create a signal producer that completes when the view controller is dismissed.
        return navigationController.reactive.pushViewController.apply((viewController, true))
            .flatMapError { _ in return SignalProducer<(), NoError>.empty }
            .then(didMoveToNilParent.producer)
            .then(SignalProducer<DetailViewModel, NoError>.empty)
            .prefix(value: viewModel)
    }

}

extension RootNavigationCoordinator: SelectionPresenter {

    func presentSelection(_ viewModel: SelectionViewModel) -> SignalProducer<SelectionViewModel, NoError> {
        guard let navigationController = navigationController else {
            fatalError()
        }

        let viewController = SelectionViewController(viewModel: viewModel)

        let selectionNavigationController = UINavigationController(rootViewController: viewController)

        // Create a signal producer that completes when the view controller is dismissed.
        return navigationController.reactive.present.apply((selectionNavigationController, true))
            .flatMapError { _ in return SignalProducer<(), NoError>.empty }
            .then(SignalProducer(value: viewModel))
            .flatMap(.concat) { viewModel in
                return viewModel.submit.values
            }
            .take(first: 1)
            .flatMap(.concat) { _ in
                return selectionNavigationController.reactive.dismiss.apply(true).producer
            }
            .flatMapError { _ in return SignalProducer<(), NoError>.empty }
            .then(SignalProducer<SelectionViewModel, NoError>.empty)
            .prefix(value: viewModel)
    }

}
