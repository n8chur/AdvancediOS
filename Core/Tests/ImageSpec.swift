import Quick
import Nimble

@testable import Core

class ImageSpec: QuickSpec {
    override func spec() {

        describe("Images") {
            describe("n8churLogo") {
                it("should load an image") {
                    let image = Image.n8churLogo.image
                    expect(image).notTo(beNil())
                }
            }
        }

    }
}
