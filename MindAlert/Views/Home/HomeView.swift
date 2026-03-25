import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                MindAlertTheme.background.ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Hello ")
                        .font(.system(size: 40, weight: .bold))
                    + Text(viewModel.safetyPlan.name)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(MindAlertTheme.mindGreen)

                    Spacer()

                    PanicButton(viewModel: viewModel)

                    Spacer()
                }
                .padding()
            }
        }
    }
}
