/// A style that can be applied to a view.
public protocol Style {
    associatedtype Styleable
    func apply(to styleable: Styleable)
}
