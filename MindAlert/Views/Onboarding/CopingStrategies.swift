import SwiftUI

struct CopingStrategies: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onYes: () -> Void
    var onNo: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 1)
                    Spacer()
                }

                Spacer(minLength: MindAlertTheme.Spacing._12)

                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    // Section header
                    HStack(spacing: MindAlertTheme.Spacing._12) {
                        Image(systemName: "tray.full")
                            .foregroundStyle(MindAlertTheme.mindGreen)
                            .font(.system(size: 32))
                        Text("Coping Strategies")
                            .font(.maHeadline)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                    }

                    Spacer()

                    // Question
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                        HStack(spacing: 0) {
                            Text("Hey ")
                                .foregroundStyle(MindAlertTheme.textPrimary)
                            Text(viewModel.safetyPlan.name)
                                .foregroundStyle(MindAlertTheme.textPrimary)
                            Text(",")
                                .foregroundStyle(MindAlertTheme.textPrimary)
                        }
                        Text("do you already have strategies that help you stay distracted in a crisis?")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                    }
                    .font(.maSplashBody)

                    Spacer()

                    // Buttons
                    VStack(spacing: MindAlertTheme.Spacing._12) {
                        Button("Yes, I do") { onYes() }
                            .buttonStyle(GreenButton())
                            .frame(maxWidth: .infinity)

                        Button("No, I need help") { onNo() }
                            .font(.maBoldBody)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                            .padding(.vertical, MindAlertTheme.Spacing._16)
                            .padding(.horizontal, MindAlertTheme.Spacing._32)
                            .background(
                                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24)
                                    .stroke(MindAlertTheme.borderSeparator, lineWidth: 1.5)
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
                .mindAlertCard()
            }
            .padding(MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
