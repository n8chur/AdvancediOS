import RxSwift
import RxCocoa
import RxExtensions
import Action
import Presentations

class SelectionViewModel: ResultViewModel {

    let isActive = BehaviorRelay(value: false)

    private(set) lazy var result = Observable<String?>.create { [weak self] observer in
        guard let self = self else { fatalError() }

        return self.submit.elements
            .subscribe(observer)
    }

    let submitTitle = Property(L10n.Selection.Submit.title)

    /// The input for the selection.
    ///
    /// The value of this property will be sent as a value in the submit action's execution signal.
    ///
    /// This should be bound to the input field.
    let input: BehaviorRelay<String?>

    /// Sends the value of input when executed.
    private(set) lazy var submit = Action<(), String?> { [weak self] in
        guard let self = self else { fatalError() }

        return Observable.just(self.input.value)
    }

    init(defaultValue: String?) {
        input = BehaviorRelay(value: defaultValue)
    }

}

protocol SelectionViewModelFactoryProtocol {
    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel
}

extension SelectionViewModelFactoryProtocol {

    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel {
        return SelectionViewModel(defaultValue: defaultValue)
    }

}
