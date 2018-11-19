import UIKit
import ReactiveSwift
import Result

/// Adopted from https://stackoverflow.com/a/33767837
extension UINavigationController {
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        pushViewController(viewController, animated: animated)

        guard let unwrappedCompletion = completion else {
            return
        }

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { unwrappedCompletion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in unwrappedCompletion() }
    }

    public func popViewController(animated: Bool, completion: (() -> Void)? = nil) {
        popViewController(animated: animated)

        guard let unwrappedCompletion = completion else {
            return
        }

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { unwrappedCompletion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in unwrappedCompletion() }
    }
}

extension Reactive where Base: UINavigationController {

    public var pushViewController: Action<(UIViewController, Bool), UIViewController, NoError> {
        let navigationController = base
        return Action { (viewController, animated) in
            return SignalProducer { [weak navigationController] (observer, _) in
                navigationController?.pushViewController(viewController, animated: animated, completion: {
                    observer.send(value: viewController)
                    observer.sendCompleted()
                })
            }

        }
    }

    public var popViewController: Action<Bool, UIViewController, NoError> {
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
