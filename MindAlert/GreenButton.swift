import SwiftUI

struct GreenButton: ButtonStyle {
    var disabled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.maBoldBody)
            .foregroundStyle(disabled ? MindAlertTheme.textTertiary : MindAlertTheme.staticWhite)
            .padding(.vertical, MindAlertTheme.Spacing._16)
            .padding(.horizontal, MindAlertTheme.Spacing._64)
            .background(
                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24)
                    .fill(disabled ? MindAlertTheme.buttonDisable : MindAlertTheme.mindGreen)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(duration: 0.2), value: configuration.isPressed)
    }
}
