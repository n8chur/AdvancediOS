import ReactiveSwift
import Result

@testable import BestPractices

class StubSelectionPresenter {

    let (makeViewModelSignal, makeViewModelObserver) = Signal<SelectionViewModel, NoError>.pipe()
    let (presentationViewModelSignal, presentationViewModelObserver) = Signal<SelectionViewModel, NoError>.pipe()

}

extension StubSelectionPresenter: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        let viewModel = SelectionViewModel()
        makeViewModelObserver.send(value: viewModel)
        return viewModel
    }

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<Never, NoError> {
        presentationViewModelObserver.send(value: viewModel)
        return SignalProducer.empty
    }
}
