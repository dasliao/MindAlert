import SwiftUI

struct OnboardingProgressIndicator: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...totalSteps, id: \.self) { step in
                // Circle with number
                ZStack {
                    Circle()
                        .fill(step <= currentStep ? MindAlertTheme.mindGreen : Color.clear)
                        .frame(width: 30, height: 30)
                    Circle()
                        .stroke(step <= currentStep ? MindAlertTheme.mindGreen : MindAlertTheme.mindLightGreen.opacity(0.5), lineWidth: 2)
                        .frame(width: 30, height: 30)
                    Text("\(step)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(step <= currentStep ? .white : MindAlertTheme.mindLightGreen.opacity(0.5))
                }

                // Connecting line (not after last step)
                if step < totalSteps {
                    Rectangle()
                        .fill(step < currentStep ? MindAlertTheme.mindGreen : MindAlertTheme.mindLightGreen.opacity(0.3))
                        .frame(height: 3)
                }
            }
        }
        .animation(.spring, value: currentStep)
    }
}
