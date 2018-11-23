import Foundation

/// A view controller with an associated ViewModel.
public protocol ViewController {
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType { get }
}
