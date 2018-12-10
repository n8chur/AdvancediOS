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
        return stackView
    }()

    let requiresConstraintBasedLayout = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(themeSwitchStack)
        themeSwitchStack.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
