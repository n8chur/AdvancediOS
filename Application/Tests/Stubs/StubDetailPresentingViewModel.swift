import ReactiveSwift
import Result

@testable import Application

class StubDetailPresentingViewModel: DetailPresentingViewModel {

    let setupViewModel = MutableProperty<DetailViewModel?>(nil)

    weak var detailPresenter: DetailPresenter?

    private(set) lazy var presentDetail = makePresentDetail(withFactory: factory) { [unowned self] (viewModel) in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

    let factory = StubDetailViewModelFactory()

}

class StubDetailViewModelFactory: DetailViewModelFactoryProtocol {

    let makeViewModel = MutableProperty<DetailViewModel?>(nil)

    func makeDetailViewModel() -> DetailViewModel {
        let viewModel = DetailViewModel(selectionFactory: self)
        makeViewModel.value = viewModel
        return viewModel
    }
}
