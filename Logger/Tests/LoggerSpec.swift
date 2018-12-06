import UIKit
import Quick
import Nimble

@testable import Logger

class LoggerSpec: QuickSpec {
    override func spec() {

        describe("Logger") {
            it("should initialize") {
                let logger = Logger.shared
                expect(logger).notTo(beNil())
            }
        }

    }
}
