import Foundation

/// A view controller that has a view model property.
public protocol ViewController {

    associatedtype ViewModelType: ViewModel

    var viewModel: ViewModelType { get }

}
