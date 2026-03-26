import SwiftUI

/// Selectable coping strategy card shown in PlanActivated.
/// Matches Play component: CopingStrategyCard
struct CopingStrategyCard: View {
    let text: String
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            // Selection indicator
            Circle()
                .fill(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator)
                .frame(width: 20, height: 20)
                .overlay(
                    Group {
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(MindAlertTheme.staticWhite)
                        }
                    }
                )

            Text(text)
                .font(.maSafetyPlanBody)
                .foregroundColor(MindAlertTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(isSelected ? MindAlertTheme.whiteGreen : MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        .overlay(
            RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16)
                .strokeBorder(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator, lineWidth: 1.5)
        )
    }
}

#Preview {
    VStack(spacing: 12) {
        CopingStrategyCard(text: "Listen to calming music", isSelected: true)
        CopingStrategyCard(text: "Take a walk outside", isSelected: false)
    }
    .padding()
    .background(MindAlertTheme.lightGray)
}
