import ReactiveSwift
import Core

class RootNavigationModel: ViewModel {

    let isActive = MutableProperty<Bool>(false)

    let rootViewModel: RootViewModel

    init() {
        rootViewModel = RootViewModel()
    }

}
