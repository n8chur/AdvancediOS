import ReactiveSwift
import Result
import Core

class DetailViewModel: ViewModel, DetailPresentingViewModel {

    weak var presenter: DetailPresenter?

    let isActive = MutableProperty<Bool>(false)

    let title = Property(value: L10n.Detail.title)

    let image = Property(value: Image.n8churLogo.image)

    let presentDetailsTitle = Property(value: L10n.Root.PresentDetails.title)

    var presentDetails: Action<(), DetailViewModel, NoError> {
        return _presentDetails
    }

    private lazy var _presentDetails = Action<(), DetailViewModel, NoError> { [weak self] _ in
        guard let presenter = self?.presenter else {
            fatalError()
        }

        let detailViewModel = DetailViewModel()
        return presenter.presentDetails(detailViewModel)
    }

}
