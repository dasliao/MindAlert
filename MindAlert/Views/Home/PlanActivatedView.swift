import SwiftUI

/// Displayed when the panic button is held for 3 seconds.
/// Matches Play page: PlanActivated
/// Variables: userName, emergencyServices, copingStrategies, currTrustContacts,
///            currProfessionalContacts, trustContactsArray, professionalContactsArray
struct PlanActivatedView: View {
    @EnvironmentObject var viewModel: SafetyPlanViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Full-screen green gradient background
            LinearGradient(
                colors: [MindAlertTheme.mindGreen, MindAlertTheme.mindLightGreen],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                            Text("Safety Plan Active")
                                .font(.maPageHeaderSmall)
                                .foregroundColor(MindAlertTheme.staticWhite.opacity(0.8))
                            Text(viewModel.safetyPlan.name)
                                .font(.maSafetyPlanTitle)
                                .foregroundColor(MindAlertTheme.staticWhite)
                        }
                        Spacer()
                        Button { dismiss() } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(MindAlertTheme.staticWhite.opacity(0.8))
                        }
                    }
                    .padding(.top, MindAlertTheme.Spacing._16)

                    // Emergency service
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                        sectionLabel("Emergency Services")
                        EmergencyServiceCallCard(service: viewModel.safetyPlan.emergencyService) {
                            viewModel.callEmergencyService()
                        }
                    }

                    // Coping strategies
                    if !viewModel.safetyPlan.strategies.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            sectionLabel("Your Coping Strategies")
                            ForEach(viewModel.safetyPlan.strategies, id: \.self) { strategy in
                                CopingStrategyCard(text: strategy, isSelected: true)
                            }
                        }
                    }

                    // Trust contacts
                    if !viewModel.safetyPlan.contacts.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            sectionLabel("People That Help")
                            ForEach(viewModel.safetyPlan.contacts.indices, id: \.self) { idx in
                                ContactCardActivated(
                                    name: viewModel.safetyPlan.contacts[idx].name,
                                    phoneNumber: viewModel.safetyPlan.contacts[idx].phoneNumber,
                                    onCall: { viewModel.callContact(at: idx) }
                                )
                            }
                        }
                    }

                    // Professional contacts
                    if !viewModel.safetyPlan.professionalContacts.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            sectionLabel("Professional Support")
                            ForEach(viewModel.safetyPlan.professionalContacts.indices, id: \.self) { idx in
                                ContactCardActivated(
                                    name: viewModel.safetyPlan.professionalContacts[idx].name,
                                    phoneNumber: viewModel.safetyPlan.professionalContacts[idx].phoneNumber,
                                    onCall: { viewModel.callProfessionalContact(at: idx) }
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)
                .padding(.bottom, MindAlertTheme.Spacing._48)
            }
        }
        .onAppear {
            HapticManager.shared.playLongHaptic()
        }
    }

    @ViewBuilder
    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.maCaption)
            .foregroundColor(MindAlertTheme.staticWhite.opacity(0.7))
            .textCase(.uppercase)
            .tracking(1)
    }
}

#Preview {
    PlanActivatedView()
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            vm.addStrategy("Listen to music")
            vm.addStrategy("Take a walk")
            vm.addContact(name: "Jamie Lee", phoneNumber: "555-1234")
            vm.setEmergencyService("911")
            return vm
        }())
}
