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
