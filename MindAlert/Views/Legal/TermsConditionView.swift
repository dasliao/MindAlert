import SwiftUI

/// Matches Play page: TermsCondition
struct TermsConditionView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                    // Header
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                        Text("Terms & Condition")
                            .font(.maLargeTitle)
                            .foregroundColor(MindAlertTheme.textPrimary)
                        Text("Last Updated: April 06, 2025")
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textSecondary)
                    }

                    // Intro
                    Text("Thank you for using MindAlert. This app was created as a personal project with the sole intention of supporting individuals through difficult emotional moments. By using MindAlert, you agree to the following terms:")
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    // Section 1
                    legalSection("1. Purpose of the App",
                        "MindAlert is designed to help users create a personal safety plan as a self-help tool during emotional distress. It does not provide medical advice, diagnosis, therapy, or emergency services. All content and tools are for informational and personal use only.")

                    // Section 2
                    legalSection("2. No Professional or Emergency Support",
                        "MindAlert is not a substitute for professional mental health care or crisis intervention. If you are in immediate danger, feel unsafe, or are in crisis, please contact a qualified mental health professional or emergency services immediately.")

                    // Section 3
                    legalSection("3. No Data Collection or Accounts",
                        "MindAlert does not collect, store, or transmit any personal data. All entries and safety plan content remain entirely on your device and under your control. There are no user accounts or cloud backups.")

                    // Section 4
                    legalSection("4. No Affiliation",
                        "MindAlert is not developed, endorsed, or affiliated with any company, healthcare provider, government agency, or mental health organization. It is an independent project created to offer quiet support, not clinical care.")

                    // Section 5
                    legalSection("5. About Your Responsibility",
                        "By using MindAlert, you acknowledge and agree that:\n\n- You are fully responsible for how you use the app and the outcomes of that use.\n- The creator of MindAlert is not liable for any direct, indirect, incidental, or consequential harm, loss, injury, or emotional distress arising from your use of the app or reliance on any content within it.\n- The app is provided \"as is,\" without warranties of any kind, express or implied.")

                    // Section 6
                    legalSection("6. Updates and Changes",
                        "MindAlert may be updated over time. Continued use after updates means you agree to any revised terms.")
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
    TermsConditionView()
}
