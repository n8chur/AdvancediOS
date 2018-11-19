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
    }

}

extension RootNavigationCoordinator: DetailPresenter {

    func presentDetails(_ viewModel: DetailViewModel) -> SignalProducer<DetailViewModel, NoError> {
        return SignalProducer<DetailViewModel, NoError> { [weak self] (observer, _) in
            guard
                let strongSelf = self,
                let navigationController = strongSelf.navigationController else {
                    fatalError()
            }

            viewModel.presenter = self

            let viewController = DetailViewController(viewModel: viewModel)
            navigationController.pushViewController(viewController, animated: true) {
                observer.send(value: viewModel)
                observer.sendCompleted()
            }
        }
    }

}
