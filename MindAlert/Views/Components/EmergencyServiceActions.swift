import SwiftUI

/// Emergency service selection + call actions.
/// Matches Play component: EmergencyServiceActions
/// States: default (no selection), _911, _988
struct EmergencyServiceActions: View {
    @Binding var selected: String  // "911", "988", or ""

    var onCall: ((String) -> Void)? = nil

    var body: some View {
        VStack(spacing: MindAlertTheme.Spacing._12) {
            serviceRow(
                title: "911",
                subtitle: "Emergency Services",
                icon: "exclamationmark.triangle.fill",
                isSelected: selected == "911"
            ) {
                selected = "911"
            }

            serviceRow(
                title: "988",
                subtitle: "Suicide & Crisis Lifeline",
                icon: "heart.fill",
                isSelected: selected == "988"
            ) {
                selected = "988"
            }

            serviceRow(
                title: "Other",
                subtitle: "Custom emergency contact",
                icon: "phone.fill",
                isSelected: selected != "911" && selected != "988" && !selected.isEmpty
            ) {
                selected = "Other"
            }
        }
    }

    @ViewBuilder
    private func serviceRow(title: String, subtitle: String, icon: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: MindAlertTheme.Spacing._12) {
                // Icon circle
                Circle()
                    .fill(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.lightGray)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(isSelected ? MindAlertTheme.staticWhite : MindAlertTheme.textSecondary)
                    )

                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                    Text(title)
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.textPrimary)
                    Text(subtitle)
                        .font(.maCaption)
                        .foregroundColor(MindAlertTheme.textSecondary)
                }

                Spacer()

                Circle()
                    .strokeBorder(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator, lineWidth: 2)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Circle()
                            .fill(MindAlertTheme.mindGreen)
                            .frame(width: 12, height: 12)
                            .opacity(isSelected ? 1 : 0)
                    )
            }
            .padding(MindAlertTheme.Spacing._16)
            .background(isSelected ? MindAlertTheme.whiteGreen : MindAlertTheme.white)
            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
            .overlay(
                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16)
                    .strokeBorder(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator, lineWidth: 1.5)
            )
            .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

/// Read-only call button for PlanActivated screen.
struct EmergencyServiceCallCard: View {
    let service: String
    var onCall: () -> Void

    var body: some View {
        Button(action: onCall) {
            HStack(spacing: MindAlertTheme.Spacing._12) {
                Circle()
                    .fill(MindAlertTheme.staticWhite.opacity(0.25))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(MindAlertTheme.staticWhite)
                    )

                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                    Text(service == "911" ? "911" : service == "988" ? "988" : service)
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.staticWhite)
                    Text(service == "988" ? "Suicide & Crisis Lifeline" : "Emergency Services")
                        .font(.maCaption)
                        .foregroundColor(MindAlertTheme.staticWhite.opacity(0.8))
                }

                Spacer()

                Image(systemName: "phone.fill")
                    .font(.system(size: 16))
                    .foregroundColor(MindAlertTheme.staticWhite)
                    .frame(width: 44, height: 44)
                    .background(MindAlertTheme.staticWhite.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding(MindAlertTheme.Spacing._16)
            .background(MindAlertTheme.mindGreen.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        EmergencyServiceActions(selected: .constant("911"))
        EmergencyServiceCallCard(service: "911", onCall: {})
    }
    .padding()
    .background(MindAlertTheme.lightGray)
}
