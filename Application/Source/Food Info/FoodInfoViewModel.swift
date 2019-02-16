import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Action

class FoodInfoViewModel: ViewModel {

    let isActive = BehaviorRelay(value: false)
    let foods: BehaviorRelay<[Food]>

    init(with foods: BehaviorRelay<[Food]>) {
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
    func makeFoodInfoViewModel(with foods: BehaviorRelay<[Food]>) -> FoodInfoViewModel
}

extension FoodInfoViewModelFactoryProtocol {

    func makeFoodInfoViewModel(with foods: BehaviorRelay<[Food]>) -> FoodInfoViewModel {
        return FoodInfoViewModel(with: foods)
    }

}
