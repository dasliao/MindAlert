import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Resources")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("If you or someone you know is in crisis, please reach out:")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(MindAlertTheme.mindBlack)

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
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                        .padding(.top, 10)
                }
                .padding()
            }
            .background(MindAlertTheme.background)
        }
    }

    private func resourceCard(title: String, detail: String, icon: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .font(.system(size: 24))
                .frame(width: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(MindAlertTheme.mindBlack)
                Text(detail)
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(MindAlertTheme.cardBackground)
        .cornerRadius(15)
    }
}
