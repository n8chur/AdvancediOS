import UIKit
import Core
import ReactiveSwift
import Result

class ApplicationCoordinator: Coordinator {

    typealias ViewModel = ApplicationViewModel
    typealias StartError = ActionError<RootNavigationPresentError>

    private var rootNavigationCoordinator: RootNavigationCoordinator?

    private let window: UIWindow

    private(set) lazy var start = Action<ViewModel, (), StartError> { viewModel in
        let setPresenter = SignalProducer<ViewModel, StartError> { [weak self] () -> ViewModel in
            guard let strongSelf = self else {
                fatalError()
            }

            viewModel.rootNavigationPresenter = strongSelf

            return viewModel
        }

        return setPresenter
            .flatMap(.merge) { return $0.presentRootNavigation.apply() }
            .ignoreValues()
    }

    init(window: UIWindow) {
        self.window = window
    }

}

extension ApplicationCoordinator: RootNavigationPresenter {

    func rootNavigationPresentation(of navigationModel: RootNavigationModel) -> SignalProducer<(), RootNavigationPresentationError> {
        let makeCoordinator = SignalProducer<RootNavigationCoordinator, NoError> { [weak self] () -> RootNavigationCoordinator in
            guard let strongSelf = self else {
                fatalError()
            }

            let coordinator = RootNavigationCoordinator(window: strongSelf.window)

            strongSelf.rootNavigationCoordinator = coordinator

            return coordinator
        }

        return makeCoordinator
            .flatMap(.merge) { $0.start.apply(navigationModel) }
            .mapError { _ in return .unknown }
    }

}
