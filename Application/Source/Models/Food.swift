import Foundation
import RxCocoa

/**
 It's not a side project if you can't have some fun, right?
 - [Original.](https://www.youtube.com/watch?v=amONEHAhLHY)
 - [Crispy.](https://www.youtube.com/watch?v=1BC1G33-fNY)
 */
enum Food {

    case beans, greens, potatoes, tomatoes

    var name: String {
        switch self {
        case .beans: return L10n.Food.beans
        case .greens: return L10n.Food.greens
        case .potatoes: return L10n.Food.potatoes
        case .tomatoes: return L10n.Food.tomatoes
        }
    }

}
