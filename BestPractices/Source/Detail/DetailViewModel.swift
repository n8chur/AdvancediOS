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

    private(set) lazy var presentSelection = Action<(), (), SelectionPresentError> { [weak self] _ in
        return SignalProducer<SelectionViewModel, SelectionPresentationError> { SelectionViewModel() }
            .flatMap(.merge) { viewModel -> SignalProducer<(), SelectionPresentationError> in
                guard
                    let self = self,
                    let presenter = self.selectionPresenter else {
                        fatalError()
                }

                self.selectionResult <~ viewModel.submit.values

                return presenter.selectionPresentation(of: viewModel)
            }
            .mapError { _ in return .unknown }
    }

}
