import SwiftUI

/// Matches Play page: EmergencyServices
/// Text: description + service items with toggle switches (911, 988)
struct EmergencyServicesView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var enable911 = true
    @State private var enable988 = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "Emergency Services", onBack: { router.navigate(to: .professionalSupport) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        Text("In a crisis, every second matters. Selecting emergency services here gives you quick access to help when you're in immediate danger or feeling unsafe.")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)

                        // Service toggles
                        VStack(spacing: 0) {
                            serviceToggleRow(title: "911", isOn: $enable911)
                            Divider().padding(.horizontal, MindAlertTheme.Spacing._16)
                            serviceToggleRow(title: "988", isOn: $enable988)
                        }
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Save & Continue",
                    primaryEnabled: enable911 || enable988,
                    onPrimary: {
                        let service = enable911 ? "911" : "988"
                        viewModel.setEmergencyService(service)
                        router.navigate(to: .setupConfirmation)
                    }
                )
            }
        }
        .onAppear {
            enable911 = viewModel.safetyPlan.emergencyService == "911"
            enable988 = viewModel.safetyPlan.emergencyService == "988"
        }
    }

    @ViewBuilder
    private func serviceToggleRow(title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(.maSafetyPlanBody)
                .foregroundColor(MindAlertTheme.textPrimary)
            Spacer()
            Toggle("", isOn: isOn)
                .tint(MindAlertTheme.mindGreen)
                .labelsHidden()
        }
        .padding(MindAlertTheme.Spacing._16)
    }
}

#Preview {
    EmergencyServicesView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
