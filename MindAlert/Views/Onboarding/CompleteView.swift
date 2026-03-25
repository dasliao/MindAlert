import SwiftUI

struct CompleteView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 3)
                    Spacer()
                }

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Checkmark + congratulations
                        HStack {
                            Spacer()
                            VStack(spacing: 12) {
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 50, weight: .light))
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                                Text("You did it,\n\(viewModel.safetyPlan.name)!")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                        }

                        // Panic Button explanation card
                        VStack(alignment: .leading, spacing: 16) {
                            Text("A \(Text("Panic Button").foregroundStyle(MindAlertTheme.mindPeach)) is now available for you.")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(MindAlertTheme.mindBlack)

                            // Nested card with button preview
                            VStack(spacing: 12) {
                                Text("It looks like this.")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.secondary)

                                // Logo circle
                                ZStack {
                                    Circle()
                                        .fill(MindAlertTheme.mindGreen)
                                        .frame(width: 80, height: 80)
                                    Image("Logo_White")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }

                                Text("To activate your Safety Plan,\n**press and hold this button for 3 seconds** during a suicidal crisis.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(MindAlertTheme.background)
                            )
                        }
                        .padding(25)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(MindAlertTheme.cardBackground)
                        )

                        // Post-activation info
                        Text("After the plan is activated, we will \(Text("message your emergency contacts").foregroundStyle(MindAlertTheme.mindGreen)) and \(Text("notify your emergency services").foregroundStyle(MindAlertTheme.mindPeach)).")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(MindAlertTheme.mindBlack)
                    }
                    .padding(.horizontal)
                }

                HStack {
                    Spacer()
                    Button("Done") {
                        viewModel.save()
                        onFinish()
                    }
                    .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom)
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
