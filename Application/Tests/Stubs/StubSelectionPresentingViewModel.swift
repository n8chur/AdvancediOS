import RxSwift
import Presentations

@testable import Application

class StubSelectionPresentingViewModel: SelectionPresentingViewModel {

    let setupViewModel = MutableProperty<SelectionViewModel?>(nil)

    weak var selectionPresenter: SelectionPresenter?

    private(set) lazy var presentSelection = makePresentSelection(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

    let factory = StubSelectionViewModelFactory()

}

class StubSelectionViewModelFactory: SelectionViewModelFactoryProtocol {

    let makeViewModel = MutableProperty<SelectionViewModel?>(nil)

    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel {
        let viewModel = SelectionViewModel(defaultValue: defaultValue)
        makeViewModel.value = viewModel
        return viewModel
    }
}
