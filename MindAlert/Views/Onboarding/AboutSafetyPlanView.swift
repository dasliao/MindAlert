import SwiftUI

/// Onboarding step 5 of 11.
/// Matches Play page: AboutSafetyPlan (no variables — static informational content)
struct AboutSafetyPlanView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "About Safety Plans", onBack: { router.navigate(to: .infoDisclaimer) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        // Logo header
                        HStack {
                            Spacer()
                            VStack(spacing: MindAlertTheme.Spacing._8) {
                                MALogo(size: 48)
                                MindAlertTitle(font: .maHeadline)
                            }
                            Spacer()
                        }
                        .padding(.vertical, MindAlertTheme.Spacing._8)

                        sectionCard(
                            title: "What is a Safety Plan?",
                            body: "A safety plan is a prioritized list of coping strategies and sources of support that people can use during a suicidal crisis. It's a tool that helps you know what to do when things get hard."
                        )

                        sectionCard(
                            title: "Why it helps",
                            body: "Research shows that having a safety plan can significantly reduce the risk of a suicidal crisis. By preparing in advance, you can act quickly when you need help most."
                        )

                        sectionCard(
                            title: "Your plan includes",
                            body: "• Coping strategies you can do on your own\n• People you trust who can help\n• Professional support contacts\n• Emergency service information"
                        )

                        sectionCard(
                            title: "The Panic Button",
                            body: "Once your safety plan is set up, MindAlert's panic button becomes available. Hold it for 3 seconds to activate your plan — it will alert your contacts and display your strategies immediately."
                        )

                        sectionCard(
                            title: "Your data stays private",
                            body: "Everything you enter is stored only on your device. MindAlert never transmits your personal information anywhere."
                        )
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Let's Set Up Your Plan",
                    onPrimary: { router.navigate(to: .peopleThatHelp) }
                )
            }
        }
    }

    @ViewBuilder
    private func sectionCard(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
            Text(title)
                .font(.maHeadline)
                .foregroundColor(MindAlertTheme.textPrimary)
            Text(body)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }
}

#Preview {
    AboutSafetyPlanView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
