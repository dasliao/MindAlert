import SwiftUI

struct CopingStrategies: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onYes: () -> Void
    var onNo: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 1)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 15) {
                            Image(systemName: "tray.full")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 36, weight: .regular))
                            Text("Coping Strategies")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("Hey ")
                                Text(viewModel.safetyPlan.name)
                                Text(",")
                            }
                            Text("do you already have strategies that help you stay distracted in a crisis?")
                        }
                        .foregroundStyle(MindAlertTheme.mindBlack)
                        .font(.system(size: 32, weight: .semibold))

                        Spacer()
                        HStack {
                            Spacer()
                            Button("Yes, I do") { onYes() }
                                .buttonStyle(GreenButton())
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button("No, I need help") { onNo() }
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(MindAlertTheme.mindLightGreen.opacity(0.5), lineWidth: 2)
                                )
                            Spacer()
                        }
                    }
                    .mindAlertCard()
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
