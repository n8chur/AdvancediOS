import RxSwift
import RxCocoa
import Action
import Presentations

protocol FoodTablePresentingViewModel: AnyObject, PresentingViewModel {
    var foodTablePresenter: FoodTablePresenter? { get set }
    var presentFoodTable: Action<Bool, FoodTableViewModel> { get }
}

extension FoodTablePresentingViewModel {

    /// Makes an action that is suitable to be set as the presentFoodTable action.
    ///
    /// This action should be executed with a Bool indicating whether the presentation should be animated.
    ///
    /// - Parameter factory: A factory to be used to generate the presented view model.
    /// - Parameter setupViewModel: This closure will be called with the presented view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presented view model if necessary.
    func makePresentFoodTable(
        withFactory factory: FoodTableViewModelFactoryProtocol,
        foods: BehaviorRelay<[Food]>,
        setupViewModel: ((FoodTableViewModel) -> Void)? = nil
        ) -> Action<Bool, FoodTableViewModel> {
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<FoodTableViewModel>? in
            guard
                let self = self,
                let presenter = self.foodTablePresenter else {
                    return nil
            }

            let viewModel = factory.makeFoodTableViewModel(foods: foods)

            setupViewModel?(viewModel)

            let presentation = presenter.foodTablePresentation(of: viewModel)

            return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol FoodTablePresenter: AnyObject {
    func foodTablePresentation(of viewModel: FoodTableViewModel) -> DismissablePresentation
}
