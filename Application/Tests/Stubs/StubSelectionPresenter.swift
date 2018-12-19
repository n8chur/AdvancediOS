import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubSelectionPresenter {

    let selectionPresentation = MutableProperty<SelectionViewModel?>(nil)

}

extension StubSelectionPresenter: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        selectionPresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
