import SwiftUI

/// Main home screen. Matches Play page: Home.
/// TextElements: greeting, userName, instruction, countdown, countdownInstruction
struct HomeView: View {
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // Greeting header
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                    Text("Hello,")
                        .font(.maPageHeaderSmall)
                        .foregroundColor(MindAlertTheme.textSecondary)

                    Text(viewModel.safetyPlan.name)
                        .font(.maLargeTitle)
                        .foregroundColor(MindAlertTheme.textPrimary)
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)
                .padding(.top, MindAlertTheme.Spacing._16)

                // Panic button — takes remaining space
                PanicButton(viewModel: viewModel)

                // Instruction text
                (Text("Hold for 3 seconds to activate your ")
                    .foregroundColor(MindAlertTheme.textSecondary) +
                Text("Safety Plan")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(MindAlertTheme.textPrimary) +
                Text(".")
                    .foregroundColor(MindAlertTheme.textSecondary))
                    .font(.maBoldBody)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            return vm
        }())
}
