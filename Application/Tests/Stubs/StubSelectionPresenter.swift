import RxCocoa
import Presentations

@testable import Application

class StubSelectionPresenter {

    let selectionPresentation = BehaviorRelay<SelectionViewModel?>(value: nil)

}

extension StubSelectionPresenter: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        selectionPresentation.accept(viewModel)
        return DismissablePresentation.stub()
    }

}
