import ReactiveSwift
import Result

@testable import Application

class StubDetailPresentingViewModel: DetailPresentingViewModel {

    let (setupViewModelSignal, setupViewModelObserver) = Signal<DetailViewModel, NoError>.pipe()

    weak var detailPresenter: DetailPresenter?

    private(set) lazy var presentDetail = makePresentDetail { [unowned self] (viewModel) in
        self.setupViewModelObserver.send(value: viewModel)
    }

    let isActive = MutableProperty<Bool>(false)

}
