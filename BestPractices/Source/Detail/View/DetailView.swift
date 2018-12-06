import UIKit
import SnapKit

class DetailView: UIView {

    let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    let selectionResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            title,
            button,
            selectionResult,
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    let requiresConstraintBasedLayout = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
