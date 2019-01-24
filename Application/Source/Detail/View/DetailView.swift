import UIKit
import SnapKit

class DetailView: UIView {

    let title = UILabel()
    let button = UIButton()
    let selectionResult = UILabel()

    private let spacingView: UIView = {
        let view = UIView()
        view.snp.makeConstraints { $0.height.equalTo(35) }
        return view
    }()

    let foodListTitle = UILabel()
    let foodList = UILabel()
    let foodInfoButton = UIButton()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            title,
            button,
            selectionResult,
            spacingView,
            foodListTitle,
            foodList,
            foodInfoButton
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
