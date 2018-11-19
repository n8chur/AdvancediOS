import ReactiveSwift
import Result
import Core

protocol SelectionPresentingViewModel: class {

    var selectionPresenter: SelectionPresenter? { get set }

    var presentSelection: Action<(), SelectionViewModel, NoError> { get }

}

protocol SelectionPresenter: class {

    func presentSelection(_ viewModel: SelectionViewModel) -> SignalProducer<SelectionViewModel, NoError>

}
