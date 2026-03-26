import SwiftUI

/// Simple service/item list row.
/// Matches Play component: Item
struct MAItem: View {
    let text: String
    var systemIcon: String? = nil

    var body: some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            if let icon = systemIcon {
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundColor(MindAlertTheme.textSecondary)
                    .frame(width: 24)
            }

            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._12))
    }
}

#Preview {
    VStack(spacing: 8) {
        MAItem(text: "911 — Emergency Services", systemIcon: "exclamationmark.triangle.fill")
        MAItem(text: "988 — Suicide & Crisis Lifeline", systemIcon: "heart.fill")
    }
    .padding()
    .background(MindAlertTheme.lightGray)
}
