import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result

class SettingsViewController: UIViewController, ViewController {

    typealias ViewModelType = SettingsViewModel

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

        settingsView.themeSwitchTitle.reactive.text <~ viewModel.themeSwitchTitle

        viewModel.isDarkTheme <~ settingsView.themeSwitch.reactive.isOnValues

        viewModel.isActive <~ reactive.isAppeared

        themeProvider.bindStyle(for: settingsView)
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}

protocol SettingsViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension SettingsViewControllerFactoryProtocol {

    func makeSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController {
        return SettingsViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
