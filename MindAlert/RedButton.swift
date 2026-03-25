import SwiftUI

struct PeachButton: ButtonStyle {
    var isSelected: Bool = true
    var fullWidth: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.maBoldBody)
            .foregroundStyle(MindAlertTheme.staticWhite)
            .padding(.vertical, MindAlertTheme.Spacing._16)
            .padding(.horizontal, MindAlertTheme.Spacing._32)
            .frame(maxWidth: fullWidth ? .infinity : nil, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24)
                    .fill(isSelected ? MindAlertTheme.mindPeach : MindAlertTheme.mindLightPeach)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(duration: 0.2), value: configuration.isPressed)
    }
}
