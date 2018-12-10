import ReactiveSwift
import Result
import Presentations

protocol SelectionPresentingViewModel: class, PresentingViewModel {
    var selectionPresenter: SelectionPresenter? { get set }
    var presentSelection: Action<(), Never, NoError> { get }
}

extension SelectionPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentSelection action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentSelection(setupViewModel: ((SelectionViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.selectionPresenter
            },
            getViewModel: { (presenter) in
                return presenter.makeSelectionViewModel()
            },
            setupViewModel: setupViewModel,
            getPresentationProducer: { (presenter, viewModel) in
                return presenter.selectionPresentation(of: viewModel)
            })
    }

}

protocol SelectionPresenter: class, Presenter {
    func makeSelectionViewModel() -> SelectionViewModel
    func selectionPresentationContext(of viewModel: SelectionViewModel) -> DismissablePresentationContext
}

fileprivate extension SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<Never, NoError> {
        return makePresentation(of: viewModel) { [weak self] viewModel in
            return self?.selectionPresentationContext(of: viewModel)
        }
    }

}
