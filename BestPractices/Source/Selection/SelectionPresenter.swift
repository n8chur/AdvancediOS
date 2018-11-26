import ReactiveSwift
import Result
import Core

protocol SelectionPresentingViewModel: class, ViewModel {
    var selectionPresenter: SelectionPresenter? { get set }
    var presentSelection: Action<(), Never, NoError> { get }
}

extension SelectionPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentSelection action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentSelection(setupViewModel: ((SelectionViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return Action<(), Never, NoError> { [weak self] _ in
            return SignalProducer<Never, NoError> { (observer, lifetime) in
                guard let presenter = self?.selectionPresenter else {
                    fatalError()
                }

                let viewModel = presenter.makeSelectionViewModel()

                setupViewModel?(viewModel)

                presenter.selectionPresentation(of: viewModel)
                    .take(during: lifetime)
                    .start(observer)
            }
        }
    }

}

protocol SelectionPresenter: class {
    func makeSelectionViewModel() -> SelectionViewModel
    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<Never, NoError>
}
