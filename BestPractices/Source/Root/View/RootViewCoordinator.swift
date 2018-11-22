import UIKit
import Core
import ReactiveSwift
import Result

class RootViewCoordinator: Coordinator {

    typealias ViewModel = RootViewModel
    typealias StartError = ActionError<RootViewPresentError>

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private(set) lazy var start = Action<ViewModel, (), StartError> { viewModel in
        return SignalProducer { [weak self] (observer, _) in
            guard let strongSelf = self else {
                fatalError()
            }

            viewModel.detailPresenter = strongSelf

            let viewController = RootViewController(viewModel: viewModel)
            strongSelf.navigationController.viewControllers = [ viewController ]

            observer.sendCompleted()
        }
    }

}

extension RootViewCoordinator: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError> {
        let makeCoordinator = SignalProducer<DetailCoordinator, NoError> { [weak self] () -> DetailCoordinator in
            guard let strongSelf = self else {
                fatalError()
            }

            return DetailCoordinator(navigationController: strongSelf.navigationController)
        }

        return makeCoordinator
            .flatMap(.merge) { coordinator in
                return coordinator.start.apply(viewModel)
                    .untilDisposal(retain: coordinator)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}
