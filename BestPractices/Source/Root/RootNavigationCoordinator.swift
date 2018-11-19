import UIKit
import Core
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
        viewModel.rootViewModel.presenter = self

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

        viewModel.presenter = self

        let viewController = DetailViewController(viewModel: viewModel)

        let didMoveToNilParent = viewController.reactive.didMoveToNilParent.take(first: 1)

        // Create a signal producer that completes when the view controller is dismissed.
        return navigationController.reactive.pushViewController.apply((viewController, true))
            .flatMapError { _ in return SignalProducer<(), NoError>.empty }
            .then(didMoveToNilParent.producer)
            .then(SignalProducer(value: viewModel))
    }

}
