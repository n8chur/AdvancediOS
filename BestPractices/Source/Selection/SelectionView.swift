import UIKit
import SnapKit
import Core

class SelectionView: UIView {

    let textField = UITextField()

    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

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
            make.top.equalTo(textField.snp.bottom).offset(10)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
