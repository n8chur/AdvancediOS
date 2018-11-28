import UIKit
import ReactiveSwift
import Result
import Core

extension DismissablePresentationContext {

    static func stub() -> DismissablePresentationContext {
        let presentation = DismissablePresentation.stub()
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
    }

}
