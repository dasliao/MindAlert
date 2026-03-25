import SwiftUI

struct OnboardingProgressIndicator: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...totalSteps, id: \.self) { step in
                ZStack {
                    Circle()
                        .fill(step <= currentStep ? MindAlertTheme.mindGreen : Color.clear)
                        .frame(width: 30, height: 30)
                    Circle()
                        .stroke(step <= currentStep ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator, lineWidth: 2)
                        .frame(width: 30, height: 30)
                    Text("\(step)")
                        .font(.maTabCaption)
                        .foregroundStyle(step <= currentStep ? MindAlertTheme.staticWhite : MindAlertTheme.textTertiary)
                }

                if step < totalSteps {
                    Rectangle()
                        .fill(step < currentStep ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator)
                        .frame(height: 2)
                }
            }
        }
        .animation(.spring, value: currentStep)
    }
}
