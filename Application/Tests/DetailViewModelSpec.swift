// swiftlint:disable function_body_length

import Quick
import Nimble
import RxSwift

@testable import Application

class DetailViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: DetailViewModel!

        beforeEach {
            viewModel = DetailViewModel(selectionFactory: StubSelectionViewModelFactory())
        }

        describe("DetailViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("selectionResult") {
                it("should intialize as nil") {
                    expect(viewModel.selectionResult.value).to(beNil())
                }

                it("should update with the value of a selection presentation") {
                    let presenter = StubSelectionPresenter()
                    viewModel.selectionPresenter = presenter

                    let selectionValue = "Test selection input"

                    _ = presenter.selectionPresentation.asObservable()
                        .unwrap()
                        .subscribe(onNext: { viewModel in
                            viewModel.input.accept(selectionValue)
                            viewModel.submit.execute(())
                        })

                    viewModel.presentSelection.execute(false)

                    expect(viewModel.selectionResult.value).to(equal(selectionValue))
                }

                it("should be used to set the default value of the selection view model") {
                    let presenter = StubSelectionPresenter()
                    viewModel.selectionPresenter = presenter

                    let value = "Test selection input"

                    _ = presenter.selectionPresentation.asObservable()
                        .unwrap()
                        .take(1)
                        .subscribe(onNext: { viewModel in
                            viewModel.input.accept(value)
                            viewModel.submit.execute(())
                        })

                    viewModel.presentSelection.execute(false)

                    var defaultValue: String??

                    _ = presenter.selectionPresentation.asObservable()
                        .unwrap()
                        .subscribe(onNext: { viewModel in
                            defaultValue = viewModel.input.value
                        })

                    viewModel.presentSelection.execute(false)

                    expect(defaultValue).to(equal(value))
                }
            }

            describe("title") {
                it("should be the correct value") {
                    expect(viewModel.title.value).to(equal(L10n.Detail.title))
                }
            }

            describe("createListText()") {
                it("should create a string list from an array of Contents") {
                    let testContent: [Food] = [.tomatoes, .potatoes]
                    let separator = " 🍅🥔 "
                    let expectedString = L10n.Food.tomatoes + separator + L10n.Food.potatoes

                    let actualString = viewModel.createListText(from: testContent, separatedBy: separator)

                    expect(actualString).to(equal(expectedString))
                }
            }
        }
    }
}

// swiftlint:enable function_body_length
