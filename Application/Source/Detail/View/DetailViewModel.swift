import ReactiveSwift
import Result
import Presentations

class DetailViewModel: ViewModel, SelectionPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var selectionPresenter: SelectionPresenter?

    let title = Property(value: L10n.Detail.title)

    /// The value of the result from a selection presentation.
    var selectionResult: Property<String?> { return Property(capturing: mutableSelectionResult) }

    let presentSelectionTitle = Property(value: L10n.Detail.Select.title)

    private(set) lazy var presentSelection = makePresentSelection(
        withFactory: selectionFactory,
        defaultValue: { [weak self] in
            return self?.selectionResult.value
        },
        setupViewModel: { [weak self] viewModel in
            guard let self = self else { fatalError() }

            self.mutableSelectionResult <~ viewModel.result
        })

    init(selectionFactory: SelectionViewModelFactoryProtocol) {
        self.selectionFactory = selectionFactory
    }

    private let mutableSelectionResult = MutableProperty<String?>(nil)
    private let selectionFactory: SelectionViewModelFactoryProtocol

}

protocol DetailViewModelFactoryProtocol: SelectionViewModelFactoryProtocol { }

extension DetailViewModelFactoryProtocol {

    func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel(selectionFactory: self)
    }

}
