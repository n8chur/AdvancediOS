import UIKit
import ReactiveSwift
import Result
import Presentations

extension DismissablePresentationContext {

    static func stub() -> DismissablePresentationContext {
        let presentation = DismissablePresentation.stub()
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
    }

}
