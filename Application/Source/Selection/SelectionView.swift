import UIKit
import SnapKit

class SelectionView: UIView {

    let textField = UITextField()
    let submitButton = UIButton()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textField,
            submitButton,
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    let requiresConstraintBasedLayout = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }

        textField.snp.makeConstraints { make in
            // Make the textfield as wide as will fit in the stack view.
            // Do not make required so it can inset based on layout margins.
            make.width.equalTo(stackView).priority(.high)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
