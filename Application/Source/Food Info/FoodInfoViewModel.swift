import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Action

class FoodInfoViewModel: ViewModel {

    let isActive = BehaviorRelay(value: false)
    let foods: Property<[Food]>

    init(with foods: Property<[Food]>) {
        self.foods = foods
        foods
            .asObservable()
            .logValue(.info, .application) { "FOODS: \($0)" }
            .subscribe()
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}

protocol FoodInfoViewModelFactoryProtocol {
    var foods: Property<[Food]> { get }

    func makeFoodInfoViewModel() -> FoodInfoViewModel
}

extension FoodInfoViewModelFactoryProtocol {

    func makeFoodInfoViewModel() -> FoodInfoViewModel {
        return FoodInfoViewModel(with: foods)
    }

}
