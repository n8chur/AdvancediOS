import ReactiveSwift
import Result
import Core

class DetailViewModel: ViewModel, SelectionPresentingViewModel {

    weak var selectionPresenter: SelectionPresenter?

    let isActive = MutableProperty(false)

    let title = Property(value: L10n.Detail.title)

    let image = Property(value: Image.n8churLogo.image)

    let selectionResult = MutableProperty<String?>(nil)

    let presentSelectionTitle = Property(value: L10n.Detail.Select.title)

    private(set) lazy var presentSelection = Action<(), (), SelectionPresentError> { [weak self] _ in
        guard
            let strongSelf = self,
            let presenter = self?.selectionPresenter else {
                fatalError()
        }

        let viewModel = SelectionViewModel()

        strongSelf.selectionResult <~ viewModel.submit.values

        return presenter.selectionPresentation(of: viewModel)
            .mapError { _ in return .unknown }
    }

}
