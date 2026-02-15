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
    func body(content: Content) -> some View {
        content
            .padding(25)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(MindAlertTheme.cardBackground)
            )
    }
}

extension View {
    func mindAlertCard() -> some View {
        modifier(MindAlertCard())
    }
}
