import SwiftUI

/// Matches Play page: CopingStrategiesIntro
/// Exact emoji + text pairs from Play export
struct CopingStrategiesIntroView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "", variant: .backOnly, onBack: { router.navigate(to: .infoDisclaimer) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        // Greeting
                        HStack(spacing: MindAlertTheme.Spacing._8) {
                            Text("👋")
                                .font(.system(size: 28))
                            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                                Text("Hello")
                                    .font(.maPageHeaderSmall)
                                    .foregroundColor(MindAlertTheme.textSecondary)
                                Text(viewModel.safetyPlan.name)
                                    .font(.maLargeTitle)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                            }
                        }

                        Text("What are a few things that help you feel a little better, even for a moment?")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)

                        // Strategy examples from Play
                        VStack(spacing: 0) {
                            strategyRow(emoji: "📺", text: "Watch a video that makes you smile or feel calm")
                            divider()
                            strategyRow(emoji: "🎧", text: "Listen to a music that soothes or comforts you")
                            divider()
                            strategyRow(emoji: "🕹️", text: "Play a game that helps you focus or relax")
                            divider()
                            strategyRow(emoji: "📚", text: "Read a book that feels familiar or safe")
                            divider()
                            strategyRow(emoji: "🐶", text: "Spend time with your pet or just sit near them")
                            divider()
                            strategyRow(emoji: "🍕", text: "Eat some delicious food from your favorite restaurant")
                            divider()
                            strategyRow(emoji: "📋", text: "You can add your own ideas too. Whatever helps you feel even a little bit more grounded is worth remembering.")
                        }
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "I'm ready",
                    onPrimary: { router.navigate(to: .copingStrategiesInput) }
                )
            }
        }
    }

    @ViewBuilder
    private func strategyRow(emoji: String, text: String) -> some View {
        HStack(alignment: .top, spacing: MindAlertTheme.Spacing._12) {
            Text(emoji)
                .font(.system(size: 22))
                .frame(width: 32)
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, MindAlertTheme.Spacing._16)
        .padding(.vertical, MindAlertTheme.Spacing._12)
    }

    @ViewBuilder
    private func divider() -> some View {
        Divider().padding(.horizontal, MindAlertTheme.Spacing._16)
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
