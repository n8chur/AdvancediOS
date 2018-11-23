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
        let viewModel = SignalProducer<SelectionViewModel, SelectionPresentationError> { SelectionViewModel() }

        return viewModel
            .flatMap(.merge) { viewModel -> SignalProducer<(), SelectionPresentationError> in
                guard
                    let strongSelf = self,
                    let presenter = self?.selectionPresenter else {
                        fatalError()
                }

                strongSelf.selectionResult <~ viewModel.submit.values

                return presenter.selectionPresentation(of: viewModel)
            }
            .mapError { _ in return .unknown }
    }

}
