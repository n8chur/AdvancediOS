import RxSwift
import RxExtensions
import Presentations

/// A view model whose view controller is presented in the context of a tab bar controller.
protocol TabBarChildViewModel: ViewModel {

    var tabBarItemTitle: Property<String> { get }

}
