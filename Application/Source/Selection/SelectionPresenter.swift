import ReactiveSwift
import Result
import Presentations

protocol SelectionPresentingViewModel: class, PresentingViewModel {
    var selectionPresenter: SelectionPresenter? { get set }
    var presentSelection: Action<Bool, SelectionViewModel, NoError> { get }
}

extension SelectionPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentSelection action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentSelection(setupViewModel: ((SelectionViewModel) -> Void)? = nil) -> Action<Bool, SelectionViewModel, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.selectionPresenter
            },
            getViewModel: { (presenter) in
                let viewModel = presenter.makeSelectionViewModel()

                setupViewModel?(viewModel)

                return viewModel
            },
            getPresentation: { (presenter, viewModel) in
                return presenter.selectionPresentation(of: viewModel)
            },
            getContext: { (presentation, viewModel, animated) in
                return ResultPresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
            })
    }

}

protocol SelectionPresenter: class {
    func makeSelectionViewModel() -> SelectionViewModel
    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation
}
