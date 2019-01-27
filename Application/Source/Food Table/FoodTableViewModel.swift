import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Action

class FoodTableViewModel: ViewModel {

    let isActive = BehaviorRelay(value: false)
    let foods: BehaviorRelay<[Food]>

    init(foods: BehaviorRelay<[Food]>) {
        self.foods = foods
        foods
            .asObservable()
            .logValue(.info, .application) { "FOODS: \($0)" }
            .subscribe()
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}

protocol FoodTableViewModelFactoryProtocol {
    func makeFoodTableViewModel(foods: BehaviorRelay<[Food]>) -> FoodTableViewModel
}

extension FoodTableViewModelFactoryProtocol {

    func makeFoodTableViewModel(foods: BehaviorRelay<[Food]>) -> FoodTableViewModel {
        return FoodTableViewModel(foods: foods)
    }

}
