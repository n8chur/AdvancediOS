import ReactiveSwift
import Result

@testable import BestPractices

class StubDetailPresentingViewModel: DetailPresentingViewModel {

    let (setupViewModelSignal, setupViewModelObserver) = Signal<DetailViewModel, NoError>.pipe()

    weak var detailPresenter: DetailPresenter?

    private(set) lazy var presentDetail: Action<(), Never, NoError> = makePresentDetail { [unowned self] viewModel in
        self.setupViewModelObserver.send(value: viewModel)
    }

    let isActive = MutableProperty<Bool>(false)

}
