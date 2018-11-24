import ReactiveSwift
import Result
import Core

protocol SelectionPresentingViewModel: class, ViewModel {
    var selectionPresenter: SelectionPresenter? { get set }
    var presentSelection: Action<(), Never, NoError> { get }
}

protocol SelectionPresenter: class {
    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<Never, NoError>
}
