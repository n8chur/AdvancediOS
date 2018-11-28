import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

extension Reactive where Base: UIViewController {

    /// Indicates whether the view controller's lifecycle is in between viewWillAppear and viewDidDisappear.
    ///
    /// Initializes with a value determined by base.view.window != nil.
    public var isAppeared: Property<Bool> {
        let trueOnAppearance = trigger(for: #selector(UIViewController.viewWillAppear(_:)))
            .map { _ in return true }

        let falseOnDisappearance = trigger(for: #selector(UIViewController.viewDidDisappear(_:)))
            .map { _ in return false }

        let signal = Signal
            .merge([
                trueOnAppearance,
                falseOnDisappearance,
            ])

        let initial = base.view.window != nil

        return Property(initial: initial, then: signal)
    }

    /// Sends the UIViewController when the view controller's parent view controller becomes nil.
    public var didMoveToNilParent: Signal<Base, NoError> {
        return  signal(for: #selector(UIViewController.didMove(toParent:)))
            .map { $0.first }
            .skipNil()
            .filter {
                $0 == nil
            }
            .map { [weak base] _ in
                return base
            }
            .skipNil()
    }

    /// Sends the UIViewController when the view is being dismissed.
    public var didDismiss: Signal<Base, NoError> {
        return signal(for: #selector(UIViewController.viewWillDisappear(_:)))
            .map { [weak base] _ in
                return base
            }
            .skipNil()
            .filter { $0.isBeingDismissed }
    }

    /// Sends the UIViewController whenever the view controller's viewDidLoad method is called.
    public var viewDidLoad: SignalProducer<Base, NoError> {
        return SignalProducer { [weak base] (observer, lifetime) in
            guard let viewController = base else {
                observer.sendCompleted()
                return
            }

            if viewController.isViewLoaded {
                observer.send(value: viewController)
                observer.sendCompleted()
                return
            }

            self.signal(for: #selector(UIViewController.viewDidLoad))
                .take(first: 1)
                .map { [weak viewController] _ in
                    return viewController
                }
                .skipNil()
                .take(during: lifetime)
                .observe(observer)
        }
    }

    /// Sends the UIViewController when the view controller's view's window becomes nil.
    public var didMoveToNilWindow: SignalProducer<Base, NoError> {
        return viewDidLoad
            .flatMap(.merge) { viewController in
                return viewController.view.reactive.signal(for: #selector(UIView.didMoveToWindow))
                    .map { _ in return viewController }
                    .filter { $0.view.window == nil }
            }
    }

    /// The execution signal completes when the view controller's presentation has completed.
    public var present: Action<(UIViewController, animated: Bool), Never, NoError> {
        let baseViewController = base
        return Action { (viewController, animated) in
            return SignalProducer { [weak baseViewController] (observer, _) in
                guard let baseViewController = baseViewController else {
                    observer.sendCompleted()
                    return
                }

                baseViewController.present(viewController, animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }

    /// Executed with a Bool representing whether the dismissal should be animated.
    ///
    /// The execution signal completes when the view controller's dismissal has completed.
    public var dismiss: Action<Bool, Never, NoError> {
        let baseViewController = base
        return Action { animated in
            return SignalProducer { [weak baseViewController] (observer, _) in
                guard let baseViewController = baseViewController else {
                    observer.sendCompleted()
                    return
                }

                baseViewController.dismiss(animated: animated, completion: {
                    observer.sendCompleted()
                })
            }

        }
    }
}
