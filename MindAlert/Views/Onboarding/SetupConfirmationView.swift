import SwiftUI

/// Matches Play page: SetupConfirmation
/// Text: "You did it" + SafetyButton preview + what happens next cards
struct SetupConfirmationView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var appeared = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: MindAlertTheme.Spacing._24) {
                        Spacer().frame(height: MindAlertTheme.Spacing._32)

                        // Congratulations header
                        VStack(spacing: MindAlertTheme.Spacing._8) {
                            Text("👍")
                                .font(.system(size: 48))
                                .scaleEffect(appeared ? 1 : 0.5)

                            HStack(spacing: MindAlertTheme.Spacing._4) {
                                Text("You did it")
                                    .font(.maLargeTitle)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                            }

                            Text(viewModel.safetyPlan.name)
                                .font(.maSafetyPlanTitle)
                                .foregroundColor(MindAlertTheme.mindGreen)
                        }
                        .opacity(appeared ? 1 : 0)

                        // Safety button preview
                        VStack(spacing: MindAlertTheme.Spacing._12) {
                            Text("The Safety Button is now available, and it looks like this.")
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .multilineTextAlignment(.center)

                            Image("TheButtonLarge")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140)

                            Text("If you're feeling overwhelmed, press and hold this button for 3 seconds to open your Safety Plan. We're here with you.")
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, MindAlertTheme.Spacing._16)
                        .opacity(appeared ? 1 : 0)

                        // What happens next
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                            Text("Once Safety Plan is Active")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            nextCard(
                                icon: "list.bullet.clipboard",
                                text: "Your coping strategies will appear first."
                            )
                            nextCard(
                                icon: "person.wave.2",
                                text: "You'll get quick shortcuts to call or text people who can help, including professionals."
                            )
                            nextCard(
                                icon: "exclamationmark.triangle",
                                text: "If you're still not safe, press and hold the \"Emergency Button\" or \"Power Button\" on your iPhone to contact emergency services."
                            )
                        }
                        .padding(MindAlertTheme.Spacing._16)
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                        .padding(.horizontal, MindAlertTheme.Spacing._8)
                        .opacity(appeared ? 1 : 0)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Save & Continue",
                    onPrimary: { router.completeOnboarding() }
                )
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appeared = true
            }
        }
    }

    @ViewBuilder
    private func nextCard(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: MindAlertTheme.Spacing._12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(MindAlertTheme.mindGreen)
                .frame(width: 24)
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    SetupConfirmationView()
        .environmentObject(AppRouter())
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            return vm
        }())
}
