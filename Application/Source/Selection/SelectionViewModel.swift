import ReactiveSwift
import Result
import Presentations

class SelectionViewModel: ResultViewModel {

    let isActive = MutableProperty(false)

    private(set) lazy var result = Signal<String?, NoError> { [weak self] (observer, lifetime) in
        guard let self = self else { fatalError() }

        self.submit.values.producer
            .take(during: lifetime)
            .start(observer)
    }

    let submitTitle = Property(value: L10n.Selection.Submit.title)

    /// The input for the selection.
    ///
    /// The value of this property will be sent as a value in the submit action's execution signal.
    ///
    /// This should be bound to the input field.
    let input: MutableProperty<String?>

    /// Sends the value of input when executed.
    private(set) lazy var submit = Action<(), String?, NoError> { [weak self] in
        guard let self = self else { fatalError() }

        return SignalProducer(value: self.input.value)
    }

    init(defaultValue: String?) {
        input = MutableProperty(defaultValue)
    }

}

protocol SelectionViewModelFactoryProtocol { }

extension SelectionViewModelFactoryProtocol {

    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel {
        return SelectionViewModel(defaultValue: defaultValue)
    }

}
