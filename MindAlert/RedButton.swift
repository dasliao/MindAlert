import SwiftUI

struct PeachButton: ButtonStyle {
    var isSelected: Bool = true
    var fullWidth: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .padding(.horizontal, 30)
            .frame(maxWidth: fullWidth ? .infinity : nil, alignment: .leading)
            .background(
                .clear,
                in: .rect(cornerRadius: 20)
            )
            .glassEffect(.regular.tint(isSelected ? MindAlertTheme.mindPeach : MindAlertTheme.mindLightPeach).interactive())
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(duration: 0.2), value: configuration.isPressed)
    }
}
