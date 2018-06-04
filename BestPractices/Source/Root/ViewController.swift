import UIKit
import MyFramework
import ReactiveCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red

        ReactiveTester.signalProducer().startWithValues { (string) in
            print(string)
        }
    }

}
