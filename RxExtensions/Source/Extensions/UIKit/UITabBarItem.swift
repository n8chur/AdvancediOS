import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITabBarItem {

    /// Bindable sink for `title` property.
    public var title: Binder<String?> {
        return Binder(self.base) { tabBarItem, title in
            tabBarItem.title = title
        }
    }

}
