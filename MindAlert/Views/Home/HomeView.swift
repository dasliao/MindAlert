import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                MindAlertTheme.background.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    // Greeting
                    (Text("Hello, ")
                        .foregroundStyle(MindAlertTheme.textPrimary)
                    + Text("\(viewModel.safetyPlan.name)!")
                        .foregroundStyle(MindAlertTheme.mindGreen))
                    .font(.maLargeTitle)
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)

                    // Panic button
                    PanicButton(viewModel: viewModel)

                    // Instruction text
                    (Text("Press the button for 3 seconds\nto activate your ")
                        .foregroundStyle(MindAlertTheme.textSecondary)
                    + Text("Safety Plan")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(MindAlertTheme.textSecondary)
                    + Text(".")
                        .foregroundStyle(MindAlertTheme.textSecondary))
                    .font(.maBoldBody)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, MindAlertTheme.Spacing._24)
                }
            }
        }
    }
}
