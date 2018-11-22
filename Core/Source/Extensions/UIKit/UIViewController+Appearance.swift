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
            .skip { arguments in
                arguments.first != nil
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
}
