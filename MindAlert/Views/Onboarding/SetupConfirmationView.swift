import SwiftUI

/// Onboarding step 11 of 11.
/// Matches Play page: SetupConfirmation (setupFinished: Bool)
/// TextElements: emoji, text2, text2_1, text, title, text2_2, text2_3, text2_4, text2_5
/// ImageElements: image1 (TheButton)
struct SetupConfirmationView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var appeared = false

    var body: some View {
        ZStack {
            MindAlertTheme.whiteGreen.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: MindAlertTheme.Spacing._32) {
                    // Success emoji + title
                    VStack(spacing: MindAlertTheme.Spacing._16) {
                        Text("🎉")
                            .font(.system(size: 64))
                            .scaleEffect(appeared ? 1 : 0.5)
                            .opacity(appeared ? 1 : 0)

                        Text("Your safety plan\nis ready!")
                            .font(.maSafetyPlanTitle)
                            .foregroundColor(MindAlertTheme.textPrimary)
                            .multilineTextAlignment(.center)
                            .opacity(appeared ? 1 : 0)
                    }

                    // Panic button preview
                    VStack(spacing: MindAlertTheme.Spacing._12) {
                        Image("TheButtonLarge")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .opacity(appeared ? 1 : 0)

                        Text("Your panic button is now active")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .opacity(appeared ? 1 : 0)
                    }

                    // Summary
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        summaryRow(icon: "checkmark.circle.fill", text: "\(viewModel.safetyPlan.strategies.count) coping strategies")
                        summaryRow(icon: "checkmark.circle.fill", text: "\(viewModel.safetyPlan.contacts.count) trust contact\(viewModel.safetyPlan.contacts.count == 1 ? "" : "s")")
                        summaryRow(icon: "checkmark.circle.fill", text: "Emergency service: \(viewModel.safetyPlan.emergencyService)")
                    }
                    .padding(MindAlertTheme.Spacing._16)
                    .background(MindAlertTheme.white.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                    .opacity(appeared ? 1 : 0)
                }
                .padding(.horizontal, MindAlertTheme.Spacing._32)
                .animation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.1), value: appeared)

                Spacer()

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Go to Home",
                    onPrimary: { router.completeOnboarding() }
                )
                .opacity(appeared ? 1 : 0)
            }
        }
        .onAppear {
            appeared = true
        }
    }

    @ViewBuilder
    private func summaryRow(icon: String, text: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(MindAlertTheme.mindGreen)
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
        }
    }
}

#Preview {
    SetupConfirmationView()
        .environmentObject(AppRouter())
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            vm.addStrategy("Listen to music")
            vm.addContact(name: "Jamie Lee", phoneNumber: "555-1234")
            vm.setEmergencyService("911")
            return vm
        }())
}
