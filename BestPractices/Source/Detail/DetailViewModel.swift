import ReactiveSwift
import Result
import Core

class DetailViewModel: ViewModel, SelectionPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var selectionPresenter: SelectionPresenter?

    let title = Property(value: L10n.Detail.title)
    let image = Property(value: Image.n8churLogo.image)
    let selectionResult = MutableProperty<String?>(nil)
    let presentSelectionTitle = Property(value: L10n.Detail.Select.title)

    private(set) lazy var presentSelection = Action<(), Never, NoError> { [weak self] _ in
        let viewModel = SignalProducer<SelectionViewModel, NoError> { SelectionViewModel() }

        return viewModel.flatMap(.merge) { viewModel -> SignalProducer<Never, NoError> in
            guard
                let self = self,
                let presenter = self.selectionPresenter else {
                    fatalError()
            }

            self.selectionResult <~ viewModel.submit.values

            return presenter.selectionPresentation(of: viewModel)
        }
    }

}
