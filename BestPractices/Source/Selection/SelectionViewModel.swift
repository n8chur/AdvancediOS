import ReactiveSwift
import Result
import Core

class SelectionViewModel: ViewModel {

    let isActive = MutableProperty(false)
    let submitTitle = Property(value: L10n.Selection.Submit.title)

    /// The input for the selection.
    ///
    /// The value of this property will be sent as a value in the submit action's exectution signal.
    ///
    /// This should be bound to the input field.
    let input = MutableProperty<String?>(nil)

    /// Sends the value of input when exectuted.
    private(set) lazy var submit = Action<(), String?, NoError> { [weak self] in
        guard let self = self else { fatalError() }

        return SignalProducer(value: self.input.value)
    }

}
