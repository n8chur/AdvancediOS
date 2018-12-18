import ReactiveSwift
import Result

@testable import Application

class StubDetailPresentingViewModel: DetailPresentingViewModel {

    let setupViewModel = MutableProperty<DetailViewModel?>(nil)

    weak var detailPresenter: DetailPresenter?

    private(set) lazy var presentDetail = makePresentDetail { [unowned self] (viewModel) in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

}
