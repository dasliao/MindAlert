import SwiftUI

// MARK: - Underline Text Field Modifier

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 3).padding(.top, 50))
            .foregroundStyle(MindAlertTheme.mindPeach)
    }
}

// MARK: - Card Modifier

struct MindAlertCard: ViewModifier {
    var cornerRadius: CGFloat = MindAlertTheme.Radius._24

    func body(content: Content) -> some View {
        content
            .padding(MindAlertTheme.Spacing._24)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(MindAlertTheme.cardBackground)
            )
    }
}

extension View {
    func mindAlertCard(cornerRadius: CGFloat = MindAlertTheme.Radius._24) -> some View {
        modifier(MindAlertCard(cornerRadius: cornerRadius))
    }
}
