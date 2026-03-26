import SwiftUI

/// Onboarding step 8 of 11.
/// Matches Play page: CopingStrategiesIntro
/// TextElements: text1, emoji (x7), text2, userName, text2_1 through text2_8, emoji_1 through emoji_7
struct CopingStrategiesIntroView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "", variant: .backOnly, onBack: { router.navigate(to: .professionalSupport) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        // Personalized greeting
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("Great job, \(viewModel.safetyPlan.name)! 🎉")
                                .font(.maLargeTitle)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            Text("Now let's think about your coping strategies — the things that help you feel better.")
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        // Coping strategy examples
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("Here are some ideas:")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            strategyExample(emoji: "🎵", text: "Listen to calming music")
                            strategyExample(emoji: "🚶", text: "Take a walk outside")
                            strategyExample(emoji: "🌬", text: "Practice deep breathing")
                            strategyExample(emoji: "📖", text: "Read a favorite book")
                            strategyExample(emoji: "☕️", text: "Make a warm drink")
                            strategyExample(emoji: "🎨", text: "Draw or color")
                            strategyExample(emoji: "🐾", text: "Spend time with a pet")
                        }
                        .padding(MindAlertTheme.Spacing._16)
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))

                        Text("You'll add your own strategies on the next screen. Choose things that actually help you — they can be simple.")
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Add My Strategies",
                    onPrimary: { router.navigate(to: .copingStrategiesInput) }
                )
            }
        }
    }

    @ViewBuilder
    private func strategyExample(emoji: String, text: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Text(emoji)
                .font(.system(size: 20))
                .frame(width: 32)
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textSecondary)
            Spacer()
        }
    }
}

#Preview {
    CopingStrategiesIntroView()
        .environmentObject(AppRouter())
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            return vm
        }())
}
