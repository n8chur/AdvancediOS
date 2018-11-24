import ReactiveSwift
import Result
import Core

class SelectionViewModel: ViewModel {

    let isActive = MutableProperty(false)
    let string = MutableProperty<String?>(nil)
    let submitTitle = Property(value: L10n.Selection.Submit.title)

    private(set) lazy var submit = Action<(), String?, NoError> { [weak self] string in
        guard let self = self else {
            fatalError()
        }

        return SignalProducer(value: self.string.value)
    }

}
