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
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        return button
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
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }

        addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(label.snp.bottom).offset(10)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
