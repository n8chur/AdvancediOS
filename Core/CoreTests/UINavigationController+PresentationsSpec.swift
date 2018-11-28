import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

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

                presentation.present.apply(false).start()

                expect(navigationController.viewControllers).to(equal([ rootViewController, presentedViewController ]))
            }

            it("should dismiss a presented view controller") {
                let presentation = navigationController.makePushPresentation(of: presentedViewController)
                presentation.present.apply(false).start()

                expect(navigationController.viewControllers).to(equal([ rootViewController, presentedViewController ]))

                presentation.dismiss.apply(false).start()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))
            }

            it("should dismiss any view controller controllers presented on top of the presented view controller") {
                let presentation = navigationController.makePushPresentation(of: presentedViewController)
                presentation.present.apply(false).start()

                let topViewController = UIViewController()
                navigationController.pushViewController(topViewController, animated: false)

                expect(navigationController.viewControllers).to(equal([
                    rootViewController,
                    presentedViewController,
                    topViewController,
                ]))

                presentation.dismiss.apply(false).start()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))
            }

            it("should should not pop the root view controller") {
                let navigationController = UINavigationController()
                let presentation = navigationController.makePushPresentation(of: rootViewController)
                presentation.present.apply(false).start()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))

                presentation.dismiss.apply(false).start()

                expect(navigationController.viewControllers).to(equal([ rootViewController ]))
            }
        }

    }
}
