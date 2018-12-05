import UIKit
import SnapKit

class SelectionView: UIView {

    let textField = UITextField()

    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    var interitemSpacingConstraints: [Constraint] = []

    let requiresConstraintBasedLayout = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }

        addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            interitemSpacingConstraints.append(
                make.top.equalTo(textField.snp.bottom).constraint)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
