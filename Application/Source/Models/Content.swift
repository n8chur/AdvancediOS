import Foundation
import RxCocoa

protocol Content {
    associatedtype CategoryType

    var name: BehaviorRelay<String> { get }
    var category: CategoryType { get }
}

/**
 It's not a side project if you can't have some fun, right?
 - [Original.](https://www.youtube.com/watch?v=amONEHAhLHY)
 - [Crispy.](https://www.youtube.com/watch?v=1BC1G33-fNY)
 */
enum Food: Content {

    case beans, greens, potatoes, tomatoes

    enum Category: Int {
        case fruit, tuber, vegetable, legume
    }

    var name: BehaviorRelay<String> {
        let value: String
        switch self {
        case .beans: value = L10n.Food.beans
        case .greens: value = L10n.Food.greens
        case .potatoes: value = L10n.Food.potatoes
        case .tomatoes: value = L10n.Food.tomatoes
        }
        return BehaviorRelay(value: value)
    }

    var category: Category {
        switch self {
        case .beans: return .legume
        case .greens: return .vegetable
        case .potatoes: return .tuber
        case .tomatoes: return .fruit
        }
    }

}
