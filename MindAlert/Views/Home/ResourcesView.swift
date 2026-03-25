import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    Text("Resources")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.top, MindAlertTheme.Spacing._8)

                    Text("If you or someone you know is in crisis, please reach out:")
                        .font(.maSafetyPlanBody)
                        .foregroundStyle(MindAlertTheme.textPrimary)

                    VStack(spacing: MindAlertTheme.Spacing._12) {
                        resourceCard(
                            title: "988 Suicide & Crisis Lifeline",
                            detail: "Call or text 988",
                            icon: "phone.fill"
                        )
                        resourceCard(
                            title: "Crisis Text Line",
                            detail: "Text HOME to 741741",
                            icon: "message.fill"
                        )
                        resourceCard(
                            title: "SAMHSA National Helpline",
                            detail: "1-800-662-4357",
                            icon: "heart.fill"
                        )
                        resourceCard(
                            title: "Veterans Crisis Line",
                            detail: "Call 988, then press 1",
                            icon: "star.fill"
                        )
                    }

                    Text("More resources coming soon.")
                        .font(.maCaption)
                        .foregroundStyle(MindAlertTheme.textTertiary)
                }
                .padding(MindAlertTheme.Spacing._24)
            }
            .background(MindAlertTheme.background.ignoresSafeArea())
        }
    }

    private func resourceCard(title: String, detail: String, icon: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._16) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .font(.system(size: 24))
                .frame(width: 40)

            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                Text(title)
                    .font(.maBoldBody)
                    .foregroundStyle(MindAlertTheme.textPrimary)
                Text(detail)
                    .font(.maCaption)
                    .foregroundStyle(MindAlertTheme.textSecondary)
            }

            Spacer()
        }
        .mindAlertCard()
    }
}
