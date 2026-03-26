import SwiftUI

/// Primary action button — replaces GreenButton / RedButton.
/// Matches Play component: Button
enum MAButtonStyle {
    case primary   // green fill, white text
    case secondary // peach fill, white text
    case tertiary  // no fill, green text
}

struct MAButton: View {
    let title: String
    let style: MAButtonStyle
    var isEnabled: Bool = true
    var fullWidth: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.maBoldBody)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: fullWidth ? .infinity : nil)
                .padding(.vertical, MindAlertTheme.Spacing._16)
                .padding(.horizontal, MindAlertTheme.Spacing._24)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24))
        }
        .disabled(!isEnabled)
    }

    private var backgroundColor: Color {
        guard isEnabled else { return MindAlertTheme.buttonDisable }
        switch style {
        case .primary:   return MindAlertTheme.mindGreen
        case .secondary: return MindAlertTheme.mindPeach
        case .tertiary:  return Color.clear
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:   return MindAlertTheme.staticWhite
        case .secondary: return MindAlertTheme.staticWhite
        case .tertiary:  return MindAlertTheme.mindGreen
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        MAButton(title: "Continue", style: .primary) {}
        MAButton(title: "Skip", style: .secondary) {}
        MAButton(title: "Learn more", style: .tertiary) {}
        MAButton(title: "Disabled", style: .primary, isEnabled: false) {}
    }
    .padding()
}
