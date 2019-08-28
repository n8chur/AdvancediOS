import Themer
import RxSwift
import RxRelay
import Logger

public class ThemeProvider: ThemeProviderProtocol {
    public let theme = BehaviorRelay<Theme>(value: .light)

    public init() {
        theme.asObservable()
            .logValue(.info, .core) { "Theme changed: \($0)" }
            .subscribe()
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}
