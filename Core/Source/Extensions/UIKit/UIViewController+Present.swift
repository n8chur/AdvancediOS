import UIKit
import ReactiveSwift
import Result

import Foundation

extension Reactive where Base: UIViewController {

    public var present: Action<(UIViewController, Bool), (), NoError> {
        let baseViewController = base
        return Action { (viewController, animated) in
            return SignalProducer { [weak baseViewController] (observer, _) in
                baseViewController?.present(viewController, animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }

    public var dismiss: Action<Bool, (), NoError> {
        let baseViewController = base
        return Action { animated in
            return SignalProducer { [weak baseViewController] (observer, _) in
                baseViewController?.dismiss(animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }

}
