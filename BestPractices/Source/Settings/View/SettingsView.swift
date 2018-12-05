import UIKit
import SnapKit

class SettingsView: UIView {

    let themeSwitchTitle = UILabel()
    let themeSwitch = UISwitch()

    private(set) lazy var themeSwitchStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            themeSwitchTitle,
            themeSwitch,
        ])
        stackView.spacing = 10
        return stackView
    }()

    let requiresConstraintBasedLayout = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(themeSwitchStack)
        themeSwitchStack.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
