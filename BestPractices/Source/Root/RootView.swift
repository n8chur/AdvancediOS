import UIKit
import SnapKit

class RootView: UIView {

    let requiresConstraintBasedLayout = true

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            // Allow label to expand up to leading/trailing margins.
            make.leading.greaterThanOrEqualTo(self.snp.leadingMargin)
            make.trailing.lessThanOrEqualTo(self.snp.trailingMargin)
            // Allow label to expand up to top and bottom of safe area.
            make.top.greaterThanOrEqualTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
