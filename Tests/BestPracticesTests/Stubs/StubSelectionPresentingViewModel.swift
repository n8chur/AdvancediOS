import ReactiveSwift
import Result

@testable import BestPractices

class StubSelectionPresentingViewModel: SelectionPresentingViewModel {

    let (setupViewModelSignal, setupViewModelObserver) = Signal<SelectionViewModel, NoError>.pipe()

    weak var selectionPresenter: SelectionPresenter?

    private(set) lazy var presentSelection: Action<(), Never, NoError> = makePresentSelection { [unowned self] viewModel in
        self.setupViewModelObserver.send(value: viewModel)
    }

    let isActive = MutableProperty<Bool>(false)

}
