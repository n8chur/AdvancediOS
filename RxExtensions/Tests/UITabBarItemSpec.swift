import Quick
import Nimble
import RxSwift
import RxCocoa
import UIKit

@testable import RxExtensions

class UITabBarItemSpec: QuickSpec {
    override func spec() {

        describe("UITabBarItem.rx.title") {
            it("should bind values to the title property") {
                let item = UITabBarItem()
                let relay = BehaviorRelay<String?>(value: nil)

                _ = relay.bind(to: item.rx.title)

                relay.accept("foo")

                expect(item.title).to(equal("foo"))
            }
        }

    }
}
