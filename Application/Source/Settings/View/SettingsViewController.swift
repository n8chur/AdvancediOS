import UIKit
import Presentations
import RxSwift
import RxCocoa
import Core

class SettingsViewController: UIViewController, ViewController {

    let viewModel: SettingsViewModel

    let themeProvider: ThemeProvider

    private(set) lazy var settingsView: SettingsView = {
        return SettingsView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: SettingsViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.themeSwitchTitle
            .bind(to: settingsView.themeSwitchTitle.rx.text)
            .disposed(by: disposeBag)

        settingsView.themeSwitch.rx.isOn
            .bind(to: viewModel.isDarkTheme)
            .disposed(by: disposeBag)

        rx.isAppeared
            .bind(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { SettingsViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}

protocol SettingsViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension SettingsViewControllerFactoryProtocol {

    func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController {
        return SettingsViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
