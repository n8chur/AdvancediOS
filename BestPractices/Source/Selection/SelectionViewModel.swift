import ReactiveSwift
import Result
import Core

class SelectionViewModel: ResultViewModel {

    typealias Result = String?

    let isActive = MutableProperty(false)

    private(set) lazy var result = Signal<Result, NoError> { [weak self] (observer, lifetime) in
        guard let self = self else { fatalError() }

        self.submit.values.producer
            .take(during: lifetime)
            .start(observer)
    }

    let submitTitle = Property(value: L10n.Selection.Submit.title)

    /// The input for the selection.
    ///
    /// The value of this property will be sent as a value in the submit action's exectution signal.
    ///
    /// This should be bound to the input field.
    let input = MutableProperty<Result>(nil)

    /// Sends the value of input when exectuted.
    private(set) lazy var submit = Action<(), Result, NoError> { [weak self] in
        guard let self = self else { fatalError() }

        return SignalProducer(value: self.input.value)
    }

}
