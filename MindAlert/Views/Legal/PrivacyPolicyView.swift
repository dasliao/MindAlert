import SwiftUI

/// Matches Play page: PrivacyPolicy
struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                    // Header
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                        Text("Privacy Policy")
                            .font(.maLargeTitle)
                            .foregroundColor(MindAlertTheme.textPrimary)
                        Text("Last Updated: April 06, 2025")
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textSecondary)
                    }

                    // Intro
                    Text("Your privacy is important. MindAlert was designed with respect for your privacy and emotional safety. The app does not collect any personal data or track your activity.")
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    // Section 1
                    legalSection("1. What Data Is Collected",
                        "None. MindAlert does not collect, transmit, or store any personal information or usage data. No login, account, or internet connection is required to use the app.")

                    // Section 2
                    legalSection("2. Where Your Data Lives",
                        "All information you enter in MindAlert, including your safety plan and contacts, is stored locally on your iPhone. It is never uploaded or shared.")

                    // Section 3
                    legalSection("3. No Analytics or Advertising",
                        "MindAlert does not use analytics tools, advertising, or third-party tracking services.")

                    // Section 4
                    legalSection("4. Your Control",
                        "You can edit or delete your data at any time. Deleting the app from your phone will remove all stored data.")

                    // Section 5
                    legalSection("5. Feedback and Support",
                        "MindAlert is not maintained by a company or organization, and it does not offer professional mental health support. If you are in distress, please reach out to a trusted person or a mental health professional.\n\nIf you have feedback or suggestions to improve the app, you're welcome to share them. The creator deeply values your input and is committed to making MindAlert more helpful for those who need it.")
                }
                .padding(MindAlertTheme.Spacing._24)
            }
            .background(MindAlertTheme.lightGray.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back to Onboarding") { dismiss() }
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.mindGreen)
                }
            }
        }
    }

    @ViewBuilder
    private func legalSection(_ title: String, _ body: String) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
            Text(title)
                .font(.maHeadline)
                .foregroundColor(MindAlertTheme.textPrimary)
            Text(body)
                .font(.maCaption)
                .foregroundColor(MindAlertTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._12))
    }
}

#Preview {
    PrivacyPolicyView()
}
