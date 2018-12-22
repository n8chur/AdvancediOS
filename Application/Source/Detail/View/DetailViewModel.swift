import RxSwift
import RxCocoa
import RxExtensions
import Presentations

class DetailViewModel: ViewModel, SelectionPresentingViewModel {

    let isActive = BehaviorRelay(value: false)

    weak var selectionPresenter: SelectionPresenter?

    let title = Property(L10n.Detail.title)

    /// The value of the result from a selection presentation.
    var selectionResult: Property<String?> { return selectionResultRelay.asProperty() }

    let presentSelectionTitle = Property(L10n.Detail.Select.title)

    private(set) lazy var presentSelection = makePresentSelection(
        withFactory: selectionFactory,
        defaultValue: { [weak self] in
            return self?.selectionResult.value
        },
        setupViewModel: { [weak self] viewModel in
            guard let self = self else { fatalError() }

            viewModel.result
                .take(1)
                .bind(to: self.selectionResultRelay)
                .disposed(by: self.disposeBag)
        })

    init(selectionFactory: SelectionViewModelFactoryProtocol) {
        self.selectionFactory = selectionFactory
    }

    private let selectionResultRelay = BehaviorRelay<String?>(value: nil)
    private let selectionFactory: SelectionViewModelFactoryProtocol
    private let disposeBag = DisposeBag()

}

protocol DetailViewModelFactoryProtocol: SelectionViewModelFactoryProtocol {
    func makeDetailViewModel() -> DetailViewModel
}

extension DetailViewModelFactoryProtocol {

    func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel(selectionFactory: self)
    }

}
