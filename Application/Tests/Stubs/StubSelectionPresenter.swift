import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubSelectionPresenter {

    let makeSelectionViewModelCall = MutableProperty<SelectionViewModel?>(nil)
    let selectionPresentation = MutableProperty<SelectionViewModel?>(nil)

}

extension StubSelectionPresenter: SelectionPresenter {

    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel {
        let viewModel = SelectionViewModel(defaultValue: defaultValue)
        makeSelectionViewModelCall.value = viewModel
        return viewModel
    }

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        selectionPresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
