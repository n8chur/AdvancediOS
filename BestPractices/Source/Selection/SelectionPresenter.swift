import ReactiveSwift
import Result
import Core

enum SelectionPresentError: Error {
    case unknown
}

protocol SelectionPresentingViewModel: class, ViewModel {
    var selectionPresenter: SelectionPresenter? { get set }
    var presentSelection: Action<(), (), SelectionPresentError> { get }
}

enum SelectionPresentationError: Error {
    case unknown
}

protocol SelectionPresenter: class {
    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<(), SelectionPresentationError>
}
