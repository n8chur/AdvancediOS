import ReactiveSwift
import Result
import Core

class DetailViewModel: ViewModel, SelectionPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var selectionPresenter: SelectionPresenter?

    let title = Property(value: L10n.Detail.title)

    /// The value of the result from a selection presentation.
    let selectionResult = MutableProperty<String?>(nil)
    let presentSelectionTitle = Property(value: L10n.Detail.Select.title)

    private(set) lazy var presentSelection = makePresentSelection() { [weak self] viewModel in
        guard let self = self else { fatalError() }

        self.selectionResult <~ viewModel.submit.values
    }

}
