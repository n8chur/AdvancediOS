import Themer
import UIKit

struct SelectionStyle: Style {
    typealias Styleable = SelectionViewController

    let background: BackgroundViewStyle
    let textField: TextFieldStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        textField = TextFieldStyle(theme: theme)
    }

    func apply(to styleable: SelectionViewController) {
        background.apply(to: styleable.selectionView)
        textField.apply(to: styleable.selectionView.textField)
    }

}

extension SelectionViewController: StyleApplicable {

    typealias StyleType = SelectionStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SelectionStyle {
        return SelectionStyle(theme: theme)
    }

}
