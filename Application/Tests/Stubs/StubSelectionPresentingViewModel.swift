import RxCocoa
import Presentations

@testable import Application

class StubSelectionPresentingViewModel: SelectionPresentingViewModel {

    let setupViewModel = BehaviorRelay<SelectionViewModel?>(value: nil)

    weak var selectionPresenter: SelectionPresenter?

    private(set) lazy var presentSelection = makePresentSelection(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.accept(viewModel)
    }

    let isActive = BehaviorRelay<Bool>(value: false)

    let factory = StubSelectionViewModelFactory()

}

class StubSelectionViewModelFactory: SelectionViewModelFactoryProtocol {

    let makeViewModel = BehaviorRelay<SelectionViewModel?>(value: nil)

    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel {
        let viewModel = SelectionViewModel(defaultValue: defaultValue)
        makeViewModel.accept(viewModel)
        return viewModel
    }
}
