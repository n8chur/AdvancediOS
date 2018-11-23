import UIKit
import ReactiveSwift
import Result

extension Reactive where Base: UINavigationController {

    /// The execution signal sends no values and completes when the view controller has finished presenting.
    public var pushViewController: Action<(UIViewController, Bool), (), NoError> {
        let navigationController = base
        return Action { (viewController, animated) in
            return SignalProducer { [weak navigationController] (observer, _) in
                navigationController?.pushViewController(viewController, animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }

    /// The execution signal sends no values and completes when the view controller has finished popping.
    public var popViewController: Action<Bool, (), NoError> {
        let navigationController = base
        return Action { animated in
            return SignalProducer { [weak navigationController] (observer, _) in
                navigationController?.popViewController(animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }
}
