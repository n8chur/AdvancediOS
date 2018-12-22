import UIKit
import RxSwift
import Action

extension Reactive where Base: UINavigationController {

    /// The execution signal sends no values and completes when the view controller has finished presenting.
    public var pushViewController: CompletableAction<(UIViewController, Bool)> {
        let navigationController = base
        return Action { (viewController, animated) in
            return Observable.create { [weak navigationController] observer in
                navigationController?.pushViewController(viewController, animated: animated, completion: {
                    observer.onCompleted()
                })
                return Disposables.create()
            }

        }
    }

    /// The execution signal sends no values and completes when the view controller has finished popping.
    ///
    /// This will also pop any view controllers pushed after the view controller being popped.
    ///
    /// Calling this on the root view controller does nothing and the action complete immediately.
    public var popViewController: CompletableAction<(UIViewController, Bool)> {
        let navigationController = base
        return Action { (viewController, animated) in
            return Observable.create { [weak navigationController] observer in
                guard
                    let navigationController = navigationController,
                    let index = navigationController.viewControllers.firstIndex(of: viewController),
                    // If index is 0 the view controller is the root view controller we should not pop.
                    index > 0 else {
                        observer.onCompleted()
                        return Disposables.create()
                }

                let viewControllerToPopTo = navigationController.viewControllers[index - 1]

                navigationController.popToViewController(viewControllerToPopTo, animated: animated, completion: {
                    observer.onCompleted()
                })

                return Disposables.create()
            }

        }
    }

    /// The execution signal sends no values and completes when the view controller has finished popping.
    public var popToViewController: CompletableAction<(UIViewController, Bool)> {
        let navigationController = base
        return CompletableAction { (viewController, animated) in
            return Observable.create { [weak navigationController] observer in
                guard let navigationController = navigationController  else {
                    observer.onCompleted()
                    return Disposables.create()
                }

                navigationController.popToViewController(viewController, animated: animated, completion: {
                    observer.onCompleted()
                })
                return Disposables.create()
            }

        }
    }
}

class UINavigationControllerDelegateProxy: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) { }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) { }

}
