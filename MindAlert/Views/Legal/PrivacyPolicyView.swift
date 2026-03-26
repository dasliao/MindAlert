import SwiftUI

/// Static privacy policy. Matches Play page: PrivacyPolicy (13 text elements).
struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    legalSection("Overview",
                        "MindAlert is committed to protecting your privacy. This Privacy Policy explains how your information is handled when you use our app.")

                    legalSection("Data Storage",
                        "All data you enter in MindAlert — including your name, contacts, coping strategies, and emergency service preferences — is stored exclusively on your device using Apple's secure local storage (UserDefaults). We do not operate any servers or databases.")

                    legalSection("Data We Do Not Collect",
                        "MindAlert does not collect, transmit, or share any personal information. There is no account creation, no sign-in, and no network communication with any external servers.")

                    legalSection("Contact Information",
                        "When you add contacts from your address book, only the name and phone number you select are saved to your safety plan. We use the system contact picker (CNContactPickerViewController) which does not grant MindAlert access to your entire contacts list.")

                    legalSection("SMS Messages",
                        "When your safety plan is activated, MindAlert can compose SMS messages to your emergency contacts. These messages are sent through your device's native messaging app — MindAlert does not intercept or store the content of these messages.")

                    legalSection("No Third Parties",
                        "MindAlert does not integrate with any third-party analytics, advertising, or data collection services.")

                    legalSection("Children's Privacy",
                        "MindAlert is not directed at children under 13. We do not knowingly collect information from children.")

                    legalSection("Your Control",
                        "You can delete all your data at any time by using the 'Rerun Onboarding' option in the Profile tab, or by deleting the app from your device.")

                    legalSection("Changes to This Policy",
                        "Any updates to this privacy policy will be reflected in an updated version of the app. Continued use of the app after changes indicates acceptance of the revised policy.")

                    legalSection("Contact",
                        "If you have questions about this privacy policy, please contact us through the App Store listing.")
                }
                .padding(MindAlertTheme.Spacing._24)
            }
            .background(MindAlertTheme.lightGray.ignoresSafeArea())
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
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
