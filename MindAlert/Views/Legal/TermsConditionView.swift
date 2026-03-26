import SwiftUI

/// Static terms & conditions. Matches Play page: TermsCondition (15 text elements).
struct TermsConditionView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    legalSection("Acceptance of Terms",
                        "By using MindAlert, you agree to these Terms and Conditions. If you do not agree, please do not use the app.")

                    legalSection("Purpose of the App",
                        "MindAlert is a mental health support tool designed to help individuals prepare and access a personal safety plan during a suicidal crisis. It is intended as a supplementary resource, not a replacement for professional care.")

                    legalSection("Not a Medical Device",
                        "MindAlert is not a medical device and is not intended to diagnose, treat, cure, or prevent any mental health condition. The app does not provide medical advice.")

                    legalSection("Emergency Situations",
                        "If you are in immediate danger, call 911 or your local emergency services immediately. Do not rely solely on MindAlert in an emergency.")

                    legalSection("User Responsibility",
                        "You are responsible for the accuracy of the information you enter in your safety plan, including contact details and coping strategies. Keep your safety plan up to date.")

                    legalSection("No Warranties",
                        "MindAlert is provided 'as is' without warranty of any kind, express or implied. We do not guarantee uninterrupted or error-free operation.")

                    legalSection("Limitation of Liability",
                        "To the maximum extent permitted by law, the developers of MindAlert shall not be liable for any indirect, incidental, or consequential damages arising from use of the app.")

                    legalSection("Third-Party Services",
                        "When you activate your safety plan, the app may open your device's phone or messaging app. Use of those services is governed by your carrier's terms of service.")

                    legalSection("Intellectual Property",
                        "All content, design, and code in MindAlert is the property of its developers. You may not reproduce or redistribute the app without permission.")

                    legalSection("Changes to Terms",
                        "We reserve the right to update these terms at any time. Continued use of the app after changes constitutes acceptance of the revised terms.")

                    legalSection("Governing Law",
                        "These terms are governed by applicable law. Any disputes will be resolved in accordance with that law.")

                    legalSection("Contact",
                        "For questions about these Terms and Conditions, please reach out through the App Store listing.")
                }
                .padding(MindAlertTheme.Spacing._24)
            }
            .background(MindAlertTheme.lightGray.ignoresSafeArea())
            .navigationTitle("Terms & Conditions")
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
    TermsConditionView()
}
