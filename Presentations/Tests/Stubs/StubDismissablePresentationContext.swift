import UIKit
import ReactiveSwift
import Result
import Presentations

extension DismissablePresentationContext {

    static func stub(withPresentation presentation: DismissablePresentation = DismissablePresentation.stub()) -> DismissablePresentationContext {
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
    }

}
