import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                MindAlertTheme.background.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    (Text("Hello, ")
                        .font(.system(size: 40, weight: .bold))
                    + Text("\(viewModel.safetyPlan.name)!")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(MindAlertTheme.mindGreen))
                    .padding(.horizontal)
                    .padding(.top)

                    PanicButton(viewModel: viewModel)

                    (Text("Press the button for 3 seconds\nto activate your ")
                        .font(.system(size: 18))
                        .foregroundStyle(.secondary)
                    + Text("Safety Plan")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.secondary)
                    + Text(".")
                        .font(.system(size: 18))
                        .foregroundStyle(.secondary))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}
