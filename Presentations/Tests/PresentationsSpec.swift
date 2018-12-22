// swiftlint:disable function_body_length

import Quick
import Nimble
import RxSwift
import Action

@testable import Presentations

class PresentationsSpec: QuickSpec {
    override func spec() {

        describe("DismissablePresentation") {
            context("present") {
                it("should call the present closure with the appropriate values when executed") {
                    let viewController = UIViewController()

                    var presentClosureCallCount = 0
                    var presentClosureViewController: UIViewController?
                    var presentClosureAnimated: Bool?
                    let presentSubject = PublishSubject<Never>()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (viewController, animated) in
                            presentClosureCallCount += 1
                            presentClosureViewController = viewController
                            presentClosureAnimated = animated

                            return presentSubject
                                .asObservable()
                                .ignoreElements()
                        },
                        dismiss: { (_, _) in return Completable.empty() },
                        didDismiss: Observable<()>.empty())

                    expect(presentClosureCallCount).to(equal(0))
                    expect(presentClosureViewController).to(beNil())
                    expect(presentClosureAnimated).to(beNil())

                    let animated = true
                    _ = presentation.present.execute(animated).subscribe()
                    presentSubject.onCompleted()

                    expect(presentClosureCallCount).to(equal(1))
                    expect(presentClosureViewController).to(equal(viewController))
                    expect(presentClosureAnimated).to(equal(animated))
                }

                it("should be disabled when the present command is executed") {
                    let viewController = UIViewController()

                    let presentSubject = PublishSubject<Never>()
                    let dismissSubject = PublishSubject<Never>()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return presentSubject.asObserver().ignoreElements() },
                        dismiss: { (_, _) in return dismissSubject.asObserver().ignoreElements() },
                        didDismiss: Observable<()>.empty())

                    expect(try? presentation.present.enabled.toBlocking().first()).to(equal(true))

                    _ = presentation.present.execute(true).subscribe()

                    expect(try? presentation.present.enabled.toBlocking().first()).to(equal(false))

                    presentSubject.onCompleted()

                    expect(try? presentation.present.enabled.toBlocking().first()).to(equal(false))

                    _ = presentation.dismiss.execute(true).subscribe()

                    expect(try? presentation.present.enabled.toBlocking().first()).to(equal(false))

                    dismissSubject.onCompleted()

                    expect(try? presentation.present.enabled.toBlocking().first()).to(equal(false))
                }
            }

            context("dismiss") {
                it("should call the dismiss closure with the appropriate values when executed") {
                    let viewController = UIViewController()

                    var dismissClosureCallCount = 0
                    var dismissClosureViewController: UIViewController?
                    var dismissClosureAnimated: Bool?
                    let dismissSubject = PublishSubject<Never>()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return Completable.empty() },
                        dismiss: { (viewController, animated) in
                            dismissClosureCallCount += 1
                            dismissClosureViewController = viewController
                            dismissClosureAnimated = animated

                            return dismissSubject.asObservable().ignoreElements()
                        },
                        didDismiss: Observable<()>.empty())

                    expect(dismissClosureCallCount).to(equal(0))
                    expect(dismissClosureViewController).to(beNil())
                    expect(dismissClosureAnimated).to(beNil())

                    let animated = true
                    _ = presentation.present.execute(animated).subscribe()

                    _ = presentation.dismiss.execute(animated).subscribe()
                    dismissSubject.onCompleted()

                    expect(dismissClosureCallCount).to(equal(1))
                    expect(dismissClosureViewController).to(equal(viewController))
                    expect(dismissClosureAnimated).to(equal(animated))
                }

                it("should be disabled after the dismiss action finishes executing") {
                    let viewController = UIViewController()

                    let presentSubject = PublishSubject<Never>()
                    let dismissSubject = PublishSubject<Never>()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return presentSubject.asObserver().ignoreElements() },
                        dismiss: { (_, _) in return dismissSubject.asObserver().ignoreElements() },
                        didDismiss: Observable<()>.empty())

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(false))

                    _ = presentation.present.execute(true).subscribe()

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(false))

                    presentSubject.onCompleted()

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(true))

                    _ = presentation.dismiss.execute(true).subscribe()

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(false))

                    dismissSubject.onCompleted()

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(false))
                }

                it("should be disabled after the didDismiss signal sends a value") {
                    let viewController = UIViewController()

                    let didDismissSubject = PublishSubject<()>()

                    let presentation = DismissablePresentation(
                        presentedViewController: viewController,
                        present: { (_, _) in return Completable.empty() },
                        dismiss: { (_, _) in return Completable.empty() },
                        didDismiss: didDismissSubject)

                    _ = presentation.present.execute(true).subscribe()

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(true))

                    didDismissSubject.onNext(())

                    expect(try? presentation.dismiss.enabled.toBlocking().first()).to(equal(false))
                }
            }
        }

    }
}

// swiftlint:enable function_body_length
