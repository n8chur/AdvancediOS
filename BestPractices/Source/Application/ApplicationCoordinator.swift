import UIKit
import Core
import ReactiveSwift
import Result

class ApplicationCoordinator: Coordinator {

    typealias ViewModel = ApplicationViewModel
    typealias StartError = ActionError<RootNavigationPresentError>

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] viewModel in
        let setup = SignalProducer<ViewModel, StartError> { () -> ViewModel in
            guard let strongSelf = self else {
                fatalError()
            }

            viewModel.rootNavigationPresenter = strongSelf

            // This should be hooked up to the UIApplication's state, but the value is currently unused so it has been
            // omitted for simplicity.
            viewModel.isActive.value = true

            return viewModel
        }

        return setup
            .flatMap(.merge) { return $0.presentRootNavigation.apply() }
            .ignoreValues()
    }

    private var rootNavigationCoordinator: RootNavigationCoordinator?
    private var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

}

extension ApplicationCoordinator: RootNavigationPresenter {

    func rootNavigationPresentation(of navigationModel: RootNavigationModel) -> SignalProducer<(), RootNavigationPresentationError> {
        let makeCoordinator = SignalProducer<RootNavigationCoordinator, NoError> { [weak self] () -> RootNavigationCoordinator in
            guard
                let strongSelf = self,
                let window = strongSelf.window else {
                    fatalError()
            }

            let coordinator = RootNavigationCoordinator(window: window)

            strongSelf.rootNavigationCoordinator = coordinator

            return coordinator
        }

        return makeCoordinator
            .flatMap(.merge) { $0.start.apply(navigationModel) }
            .mapError { _ in return .unknown }
    }

}
