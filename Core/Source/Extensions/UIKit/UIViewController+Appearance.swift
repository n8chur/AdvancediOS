import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

extension Reactive where Base: UIViewController {

    public var isAppeared: Signal<Bool, NoError> {
        let trueOnAppearance = trigger(for: #selector(UIViewController.viewWillAppear(_:)))
            .map { _ in return true }

        let falseOnDisappearance = trigger(for: #selector(UIViewController.viewDidDisappear(_:)))
            .map { _ in return false }

        return Signal.merge([
            trueOnAppearance,
            falseOnDisappearance,
        ])
    }

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

    public var didDismiss: Signal<Base, NoError> {
        return signal(for: #selector(UIViewController.viewWillDisappear(_:)))
            .map { [weak base] _ in
                return base
            }
            .skipNil()
            .filter { $0.isBeingDismissed }
    }

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

    public var didMoveToNilWindow: SignalProducer<Base, NoError> {
        return viewDidLoad
            .flatMap(.merge) { viewController in
                return viewController.view.reactive.signal(for: #selector(UIView.didMoveToWindow))
                    .map { _ in return viewController }
                    .filter { $0.view.window == nil }
            }
    }
}
