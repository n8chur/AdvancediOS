import UIKit
import SnapKit

class DetailView: UIView {

    let title = UILabel()
    let button = UIButton()
    let selectionResult = UILabel()

    let foodListTitle = UILabel()
    let foodList = UILabel()
    let foodInfoButton = UIButton()

    private(set) lazy var selectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            title,
            button,
            selectionResult
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private(set) lazy var foodStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            foodListTitle,
            foodList,
            foodInfoButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private(set) lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            selectionStackView,
            foodStackView
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    let requiresConstraintBasedLayout = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
