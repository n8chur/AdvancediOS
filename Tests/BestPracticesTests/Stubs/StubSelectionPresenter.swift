import ReactiveSwift
import Result
import Core

@testable import BestPractices

class StubSelectionPresenter {

    let (makeSelectionViewModelSignal, makeSelectionViewModelObserver) = Signal<SelectionViewModel, NoError>.pipe()
    let (selectionPresentationContextSignal, selectionPresentationContextObserver) = Signal<SelectionViewModel, NoError>.pipe()

}

extension StubSelectionPresenter: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        let viewModel = SelectionViewModel()
        makeSelectionViewModelObserver.send(value: viewModel)
        return viewModel
    }

    func selectionPresentationContext(of viewModel: SelectionViewModel) -> DismissablePresentationContext {
        selectionPresentationContextObserver.send(value: viewModel)
        return DismissablePresentationContext.stub()
    }

}
