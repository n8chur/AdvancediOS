import Themer
import UIKit
import Core

struct SelectionStyle: Style {
    typealias Styleable = SelectionViewController

    let theme: Theme
    let background: BackgroundViewStyle
    let textField: TextFieldStyle
    let submitButton: ButtonStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        textField = TextFieldStyle(theme: theme)
        submitButton = ButtonStyle(theme: theme)
    }

    func apply(to styleable: SelectionViewController) {
        let view = styleable.selectionView

        background.apply(to: view)
        textField.apply(to: view.textField)
        submitButton.apply(to: view.submitButton)

        view.interitemSpacingConstraints.forEach { constraint in
            constraint.update(offset: theme.layout.interitemSpacing)
        }
    }

}

extension SelectionViewController: StyleApplicable {

    typealias StyleType = SelectionStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SelectionStyle {
        return SelectionStyle(theme: theme)
    }

}
