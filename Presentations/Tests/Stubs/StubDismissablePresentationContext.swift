import UIKit
import Presentations

extension DismissablePresentationContext where PresentedViewModel == StubViewModel {

    static func stub(
        withPresentation presentation: DismissablePresentation = DismissablePresentation.stub()
    ) -> DismissablePresentationContext<StubViewModel> {
        let viewModel = StubViewModel()
        return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: false, dismissAnimated: false)
    }

}
