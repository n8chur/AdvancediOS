import Quick
import Nimble
import ReactiveSwift
import Result
import Core

@testable import BestPractices

class RootViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: RootViewModel!

        beforeEach {
            viewModel = RootViewModel()
        }

        describe("RootViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("testText") {
                context("when isActive is true") {
                    it("should send the correct value") {
                        expect(viewModel.testText.value).to(beNil())

                        viewModel.isActive.value = true

                        expect(viewModel.testText.value).toEventually(equal(L10n.Root.testText))
                    }
                }
            }

            describe("presentDetail") {
                it("should call the presenter to create a presentation") {
                    let presenter = StubDetailPresenter()
                    viewModel.detailPresenter = presenter

                    let viewModelsProperty = MutableProperty<[DetailViewModel]?>(nil)
                    viewModelsProperty <~ presenter.viewModel.collect()

                    viewModel.presentDetail.apply()
                        .on(completed: {
                            presenter.viewModelObserver.sendCompleted()
                        })
                        .start()

                    guard let viewModels = viewModelsProperty.value else {
                        fail("Failed to get view models.")
                        return
                    }

                    expect(viewModels).to(haveCount(1))
                }
            }

            describe("image") {
                it("should be the n8chur logo") {
                    expect(viewModel.image.value).to(equal(Image.n8churLogo.image))
                }
            }
        }

    }
}

class StubDetailPresenter: DetailPresenter {

    let (viewModel, viewModelObserver) = Signal<DetailViewModel, NoError>.pipe()

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError> {
        return SignalProducer { [weak self] () -> DetailViewModel in
                self?.viewModelObserver.send(value: viewModel)
                return viewModel
            }
            .ignoreValues()
    }

}
