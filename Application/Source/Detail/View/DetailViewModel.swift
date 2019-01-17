import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Action

class DetailViewModel: ViewModel, SelectionPresentingViewModel {

    let isActive = BehaviorRelay(value: false)

    weak var selectionPresenter: SelectionPresenter?

    let title = Property(L10n.Detail.title)

    /// The value of the result from a selection presentation.
    var selectionResult: Property<String?> { return selectionResultRelay.asProperty() }

    let presentSelectionTitle = Property(L10n.Detail.Select.title)

    let contentsListTitle = Property(L10n.Detail.ContentsList.title)
    let contentsButtonTitle = Property(L10n.Detail.ContentsButton.title)

    let presentContents = CocoaAction { _ in
        print("Content button pressed")
        return .empty()
    }

    let content: [Food] = [
        .beans,
        .greens,
        .potatoes,
        .tomatoes
    ]

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
