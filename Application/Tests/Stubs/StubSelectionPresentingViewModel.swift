import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubSelectionPresentingViewModel: SelectionPresentingViewModel {

    let setupViewModel = MutableProperty<SelectionViewModel?>(nil)

    weak var selectionPresenter: SelectionPresenter?

    private(set) lazy var presentSelection: Action<(), Never, NoError> = makePresentSelection { [unowned self] viewModel in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

}
