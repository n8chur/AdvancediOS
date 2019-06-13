import RxSwift
import RxCocoa
import Action
import Presentations

protocol FoodInfoPresentingViewModel: AnyObject, PresentingViewModel {
    var foodInfoPresenter: FoodInfoPresenter? { get set }
    var presentFoodInfo: Action<Bool, FoodInfoViewModel> { get }
}

extension FoodInfoPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentFoodInfo action.
    ///
    /// This action should be executed with a Bool indicating whether the presentation should be animated.
    ///
    /// - Parameter factory: A factory to be used to generate the presented view model.
    /// - Parameter setupViewModel: This closure will be called with the presented view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presented view model if necessary.
    func makePresentFoodInfo(
        withFactory factory: FoodInfoViewModelFactoryProtocol,
        setupViewModel: ((FoodInfoViewModel) -> Void)? = nil
    ) -> Action<Bool, FoodInfoViewModel> {
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<FoodInfoViewModel>? in
            guard
                let self = self,
                let presenter = self.foodInfoPresenter else {
                    return nil
            }

            let viewModel = factory.makeFoodInfoViewModel()

            setupViewModel?(viewModel)

            let presentation = presenter.foodInfoPresentation(of: viewModel)

            return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol FoodInfoPresenter: AnyObject {
    func foodInfoPresentation(of viewModel: FoodInfoViewModel) -> DismissablePresentation
}
