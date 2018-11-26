import Quick
import Nimble
import ReactiveSwift
import Result

@testable import BestPractices

class DetailViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: DetailViewModel!

        beforeEach {
            viewModel = DetailViewModel()
        }

        describe("DetailViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("presentSelection") {
                it("should call the presenter to create a presentation") {
                    let presenter = StubSelectionPresenter()
                    viewModel.selectionPresenter = presenter

                    let viewModelsProperty = MutableProperty<[SelectionViewModel]?>(nil)
                    viewModelsProperty <~ presenter.viewModel.collect()

                    viewModel.presentSelection.apply()
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

            describe("selectionResult") {
                it("should intialize as nil") {
                    expect(viewModel.selectionResult.value).to(beNil())
                }

                it("should update with the value of a selection presentation") {
                    let presenter = StubSelectionPresenter()
                    viewModel.selectionPresenter = presenter

                    let selectionValue = "Test selection input"

                    presenter.viewModel.observeValues { viewModel in
                        viewModel.input.value = selectionValue
                        viewModel.submit.apply().start()
                    }

                    viewModel.presentSelection.apply().start()

                    expect(viewModel.selectionResult.value).to(equal(selectionValue))
                }
            }

            describe("title") {
                it("should be the correct value") {
                    expect(viewModel.title.value).to(equal(L10n.Detail.title))
                }
            }
        }

    }
}

class StubSelectionPresenter: SelectionPresenter {

    let (viewModel, viewModelObserver) = Signal<SelectionViewModel, NoError>.pipe()

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<Never, NoError> {
        return SignalProducer { [weak self] () -> SelectionViewModel in
                self?.viewModelObserver.send(value: viewModel)
                return viewModel
            }
            .ignoreValues()
    }

}
