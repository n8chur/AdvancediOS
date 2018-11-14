import UIKit

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

        self.backgroundColor = .red

        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            label.topAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
