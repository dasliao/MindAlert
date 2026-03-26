import SwiftUI

/// Onboarding step 1 of 11.
/// Matches Play page: SplashScreen
struct SplashScreenView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Logo + Brand title
                VStack(spacing: MindAlertTheme.Spacing._16) {
                    MALogo(size: 64)

                    MindAlertTitle(font: .maLargeTitle)
                }

                Spacer().frame(height: MindAlertTheme.Spacing._48)

                // Hero text
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    Text("MindAlert helps you prepare a safety plan for suicidal crisis so you can stay safe.")
                        .font(.maSplashBody)
                        .foregroundColor(MindAlertTheme.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("After creating your safety plan, a panic button will become available.")
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    // Bullet points
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        bulletRow(emoji: "🔗", text: "Links to your coping strategies")
                        bulletRow(emoji: "📢", text: "Alerting your emergency contacts")
                        bulletRow(emoji: "🚑", text: "Alerting medical emergency services")
                    }
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)

                Spacer()

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Get Started",
                    onPrimary: { router.navigate(to: .initial) }
                )
            }
        }
    }

    @ViewBuilder
    private func bulletRow(emoji: String, text: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Text(emoji)
                .font(.system(size: 18))
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textSecondary)
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
