import Action
import RxSwift

public extension Action {

    /// Sends () when the action's execution signal completes.
    ///
    /// Never errors.
    var completed: Observable<()> {
        return executionObservables
            .flatMap { observable in
                return observable
                    .ignoreElements()
                    .andThen(Single.just(()))
            }
            .catchError { _ in Observable.empty() }
    }

}
