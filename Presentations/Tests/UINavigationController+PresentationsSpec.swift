import Quick
import Nimble
import RxSwift

@testable import Presentations

class UINavigationControllerPresentationsSpec: QuickSpec {
    override func spec() {

        describe("UINavigationController.makePushPresentation(of:)") {

            var rootViewController: UIViewController!
            var navigationController: UINavigationController!
            var presentedViewController: UIViewController!

            beforeEach {
                rootViewController = UIViewController()
                navigationController = UINavigationController(rootViewController: rootViewController)
                presentedViewController = UIViewController()
            }

            it("should push a new view controller when presented") {
                let presentation = navigationController.makePushPresentation(of: presentedViewController)

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))

                _ = presentation.present.execute(false).subscribe()

                expect(navigationController.viewControllers).to(equal([ rootViewController, presentedViewController ]))
            }

            it("should dismiss a presented view controller") {
                let presentation = navigationController.makePushPresentation(of: presentedViewController)
                _ = presentation.present.execute(false).subscribe()

                expect(navigationController.viewControllers).to(equal([ rootViewController, presentedViewController ]))

                presentation.dismiss.execute(false).subscribe()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))
            }

            it("should dismiss any view controller controllers presented on top of the presented view controller") {
                let presentation = navigationController.makePushPresentation(of: presentedViewController)
                _ = presentation.present.execute(false).subscribe()

                let topViewController = UIViewController()
                navigationController.pushViewController(topViewController, animated: false)

                expect(navigationController.viewControllers).to(equal([
                    rootViewController,
                    presentedViewController,
                    topViewController,
                ]))

                _ = presentation.dismiss.execute(false).subscribe()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))
            }

            it("should should not pop the root view controller") {
                let navigationController = UINavigationController()
                let presentation = navigationController.makePushPresentation(of: rootViewController)
                _ = presentation.present.execute(false).subscribe()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))

                _ = presentation.dismiss.execute(false).subscribe()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))
            }
        }

    }
}
