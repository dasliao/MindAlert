import SwiftUI

/// Onboarding step 10 of 11.
/// Matches Play page: EmergencyServices (emergencyService: AnyHashable)
/// TextElements: text1, text2, serviceName, serviceName_1
struct EmergencyServicesView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var selected: String = "911"

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "Emergency Services", onBack: { router.navigate(to: .copingStrategiesInput) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("Almost there, \(viewModel.safetyPlan.name)!")
                                .font(.maLargeTitle)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            Text("Choose the emergency service that will be activated when your safety plan is triggered.")
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        EmergencyServiceActions(selected: $selected)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Continue",
                    primaryEnabled: !selected.isEmpty && selected != "Other",
                    onPrimary: {
                        viewModel.setEmergencyService(selected)
                        router.navigate(to: .setupConfirmation)
                    }
                )
            }
        }
        .onAppear {
            selected = viewModel.safetyPlan.emergencyService
        }
    }
}

#Preview {
    EmergencyServicesView()
        .environmentObject(AppRouter())
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            return vm
        }())
}
