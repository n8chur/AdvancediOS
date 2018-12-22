import UIKit
import RxSwift
import Presentations

extension DismissablePresentation {

    static func stub() -> DismissablePresentation {
        let viewController = UIViewController()
        return DismissablePresentation(
            presentedViewController: viewController,
            present: { (_, _)  in
                return Completable.empty()
            },
            dismiss: { (_, _) in
                return Completable.empty()
            },
            didDismiss: Observable<()>.empty())
    }

}
