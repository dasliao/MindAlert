import SwiftUI

struct OnboardingProgressIndicator: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { step in
                Capsule()
                    .fill(step <= currentStep
                        ? MindAlertTheme.mindGreen
                        : MindAlertTheme.mindLightGreen.opacity(0.3))
                    .frame(width: step == currentStep ? 32 : 16, height: 6)
            }
        }
        .animation(.spring, value: currentStep)
    }
}
