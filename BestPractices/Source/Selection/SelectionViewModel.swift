import ReactiveSwift
import Result
import Core

class SelectionViewModel: ViewModel {

    enum ValidationError: Error {
        case empty
    }

    let isActive = MutableProperty(false)

    let string = MutableProperty<String?>(nil)

    let submitTitle = Property(value: L10n.Selection.Submit.title)

    private(set) lazy var submit: Action<(), String?, NoError> = {
        return Action<(), String?, NoError> { [weak self] string in
            guard let strongSelf = self else {
                fatalError()
            }

            return SignalProducer(value: strongSelf.string.value)
        }
    }()

}
