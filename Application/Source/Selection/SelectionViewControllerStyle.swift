import Themer
import UIKit
import Core

struct SelectionViewControllerStyle: Style {
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

        view.stackView.spacing = theme.layout.interitemSpacing
        view.stackView.layoutMargins = theme.layout.contentLayoutMargins
    }

}
