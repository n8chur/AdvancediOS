/// A style that can be applied to a view.
public protocol Style {
    associatedtype Styleable
    func apply(to styleable: Styleable)
}

/// A struct or class that can have a style applied to it.
///
/// This is typically a UIView or UIViewController subclass.
public protocol StyleApplicable {
    associatedtype StyleType: Style where StyleType.Styleable == Self

    /// The theme type of the style.
    ///
    /// This is typically an enum (e.g. .dark/.light).
    associatedtype ThemeType

    /// Should return a style for the provided theme that can be applied to the
    /// receiver.
    func makeStyleWithTheme(_ theme: ThemeType) -> StyleType
}

public extension StyleApplicable {

    /// Applys the provided style to the receiver.
    public func applyStyle(_ style: StyleType) {
        style.apply(to: self)
    }

}
