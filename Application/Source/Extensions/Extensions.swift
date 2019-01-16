import UIKit

extension UILabel {

    static func centeredLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
}
