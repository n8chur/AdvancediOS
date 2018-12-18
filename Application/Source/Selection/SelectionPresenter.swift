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
    func makePresentSelection(
        withDefaultValue defaultValue: (() -> String?)? = nil,
        setupViewModel: ((SelectionViewModel) -> Void)? = nil
    ) -> Action<Bool, SelectionViewModel, NoError> {
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<SelectionViewModel>? in
            guard
                let self = self,
                let presenter = self.selectionPresenter else {
                    return nil
            }

            let value = defaultValue?()
            let viewModel = presenter.makeSelectionViewModel(withDefaultValue: value)

            setupViewModel?(viewModel)

            let presentation = presenter.selectionPresentation(of: viewModel)

            return ResultPresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol SelectionPresenter: class {
    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel
    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation
}
