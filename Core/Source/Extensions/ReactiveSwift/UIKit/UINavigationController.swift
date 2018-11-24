import UIKit
import ReactiveSwift
import Result

extension Reactive where Base: UINavigationController {

    /// The execution signal sends no values and completes when the view controller has finished presenting.
    public var pushViewController: Action<(UIViewController, Bool), Never, NoError> {
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
    public var popViewController: Action<(UIViewController, Bool), Never, NoError> {
        let navigationController = base
        return Action { (viewController, animated) in
            return SignalProducer { [weak navigationController] (observer, _) in
                guard
                    let navigationController = navigationController,
                    let index = navigationController.viewControllers.firstIndex(of: viewController),
                    // If index is 0 the view controller is the root view controller so we should not pop.
                    index > 0 else {
                        observer.sendCompleted()
                        return
                }

                let viewControllerToPopTo = navigationController.viewControllers[index - 1]

                navigationController.popToViewController(viewControllerToPopTo, animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }

    /// The execution signal sends no values and completes when the view controller has finished popping.
    public var popToViewController: Action<(UIViewController, Bool), Never, NoError> {
        let navigationController = base
        return Action { (viewController, animated) in
            return SignalProducer { [weak navigationController] (observer, _) in
                guard
                    let navigationController = navigationController,
                    navigationController.viewControllers.last != viewController else {
                        observer.sendCompleted()
                        return
                }

                navigationController.popToViewController(viewController, animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }
}
