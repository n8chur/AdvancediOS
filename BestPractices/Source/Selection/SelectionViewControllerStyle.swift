import Themer
import UIKit
import Core

struct SelectionStyle: Style {
    typealias Styleable = SelectionViewController

    let background: BackgroundViewStyle
    let textField: TextFieldStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        textField = TextFieldStyle(theme: theme)
    }

    func apply(to styleable: SelectionViewController) {
        let view = styleable.selectionView

        background.apply(to: view)
        textField.apply(to: view.textField)
    }

}

extension SelectionViewController: StyleApplicable {

    typealias StyleType = SelectionStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SelectionStyle {
        return SelectionStyle(theme: theme)
    }

}
