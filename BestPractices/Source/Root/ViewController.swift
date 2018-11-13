import UIKit
import MyFramework
import ReactiveCocoa
import ReactiveSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red

        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.numberOfLines = 0

        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.leadingAnchor.constraint(lessThanOrEqualTo: self.view.leadingAnchor),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
            label.topAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        label.reactive.text <~ ReactiveTester.signalProducer().on(value: { text in
            print(text)
        })
    }

}
