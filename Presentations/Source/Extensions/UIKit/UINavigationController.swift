import UIKit
import RxSwift
import Action
import ObjectiveC

private struct AssociatedKeys {
    static var push = "rx_navigationController_push"
    static var pop = "rx_navigationController_pop"
    static var popTo = "rx_navigationController_popTo"
}

extension Reactive where Base: UINavigationController {

    /// The execution signal sends no values and completes when the view controller has finished presenting.
    public var pushViewController: CompletableAction<(UIViewController, Bool)> {
        let push: CompletableAction<(UIViewController, Bool)>
        if let associatedPush = objc_getAssociatedObject(base, &AssociatedKeys.push) as? CompletableAction<(UIViewController, Bool)> {
            push = associatedPush
        } else {
            push = self.makePushViewController()
            objc_setAssociatedObject(base, &AssociatedKeys.push, push, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return push
    }

    private func makePushViewController() -> CompletableAction<(UIViewController, Bool)> {
        let navigationController = base
        return  Action { (viewController, animated) in
            return Observable.create { [weak navigationController] observer in
                guard let navigationController = navigationController else {
                    observer.onCompleted()
                    return Disposables.create()
                }

                navigationController.pushViewController(viewController, animated: animated, completion: {
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
        let pop: CompletableAction<(UIViewController, Bool)>
        if let associatedPop = objc_getAssociatedObject(base, &AssociatedKeys.pop) as? CompletableAction<(UIViewController, Bool)> {
            pop = associatedPop
        } else {
            pop = self.makePopViewController()
            objc_setAssociatedObject(base, &AssociatedKeys.pop, pop, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return pop
    }

    private func makePopViewController() -> CompletableAction<(UIViewController, Bool)> {
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
        let popTo: CompletableAction<(UIViewController, Bool)>
        if let associatedPopTo = objc_getAssociatedObject(base, &AssociatedKeys.popTo) as? CompletableAction<(UIViewController, Bool)> {
            popTo = associatedPopTo
        } else {
            popTo = self.makePopToViewController()
            objc_setAssociatedObject(base, &AssociatedKeys.popTo, popTo, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return popTo
    }

    private func makePopToViewController() -> CompletableAction<(UIViewController, Bool)> {
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
