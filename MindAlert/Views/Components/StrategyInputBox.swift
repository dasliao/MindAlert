import SwiftUI

/// Numbered text input field for entering a coping strategy.
/// Matches Play component: StrategyInputBox
struct StrategyInputBox: View {
    let number: Int
    @Binding var text: String
    var isFocused: Bool = false

    var body: some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Text("\(number).")
                .font(.maBoldBody)
                .foregroundColor(isFocused ? MindAlertTheme.mindGreen : MindAlertTheme.textTertiary)
                .frame(width: 28, alignment: .trailing)
                .animation(.easeInOut(duration: 0.2), value: isFocused)

            TextField("Add a coping strategy...", text: $text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
        }
        .padding(.horizontal, MindAlertTheme.Spacing._16)
        .padding(.vertical, MindAlertTheme.Spacing._16)
        .background(isFocused ? MindAlertTheme.whiteGreen : MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        .overlay(
            RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16)
                .strokeBorder(
                    isFocused ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator,
                    lineWidth: isFocused ? 1.5 : 1
                )
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

/// Strategy card shown in ProfileSetting.
/// Matches Play component: StrategySetttingCard
struct StrategySettingCard: View {
    let number: Int
    let text: String
    var onDelete: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Text("\(number).")
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textTertiary)
                .frame(width: 28, alignment: .trailing)

            Text(text)
                .font(.maSafetyPlanBody)
                .foregroundColor(MindAlertTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let onDelete {
                Button(action: onDelete) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(MindAlertTheme.mindPeach)
                }
            }
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }
}

#Preview {
    VStack(spacing: 12) {
        StrategyInputBox(number: 1, text: .constant("Listen to music"), isFocused: true)
        StrategyInputBox(number: 2, text: .constant(""), isFocused: false)
        StrategySettingCard(number: 1, text: "Listen to music", onDelete: {})
    }
    .padding()
    .background(MindAlertTheme.lightGray)
}
