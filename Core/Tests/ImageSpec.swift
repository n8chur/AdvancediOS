import Quick
import Nimble

@testable import Core

class ImageSpec: QuickSpec {
    override func spec() {

        describe("Images") {
            describe("n8churLogo") {
                it("should load the correct image name") {
                    let name = Image.n8churLogo.name
                    expect(name).to(equal("n8chur Logo"))
                }
            }
        }

    }
}
