import SwiftUI

/// Matches Play page: Home (Safety Button)
/// Text: "Hello" + name + hold instruction
struct HomeView: View {
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // Greeting
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                    Text("Hello")
                        .font(.maPageHeaderSmall)
                        .foregroundColor(MindAlertTheme.textSecondary)
                    Text(viewModel.safetyPlan.name)
                        .font(.maLargeTitle)
                        .foregroundColor(MindAlertTheme.textPrimary)
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)
                .padding(.top, MindAlertTheme.Spacing._16)

                // Panic button
                PanicButton(viewModel: viewModel)

                // Instruction
                Text("Press and hold the button for 3 seconds to activate your Safety Plan.")
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textSecondary)
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
        .environmentObject(AppRouter())
}
