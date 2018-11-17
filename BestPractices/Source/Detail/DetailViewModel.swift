import ReactiveSwift
import Core

class DetailViewModel: ViewModel {

    let isActive = MutableProperty<Bool>(false)

    let title = Property(value: L10n.Detail.title)

}
