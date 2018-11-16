import UIKit
import SnapKit
import Core

class RootView: UIView {

    let requiresConstraintBasedLayout = true

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView(image: Image.n8churLogo.image)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }

        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            // Allow label to expand up to leading/trailing margins.
            make.leading.greaterThanOrEqualTo(self.snp.leadingMargin)
            make.trailing.lessThanOrEqualTo(self.snp.trailingMargin)
            // Allow label to expand up to bottom of safe area.
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
