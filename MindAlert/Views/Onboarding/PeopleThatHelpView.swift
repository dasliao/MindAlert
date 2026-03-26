import SwiftUI

/// Matches Play page: PeopleThatHelp
/// Text from Play: default help message + "Import from Contacts"
struct PeopleThatHelpView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var showContactPicker = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "People That Help", onBack: { router.navigate(to: .copingStrategiesInput) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        Text("In hard moments, just being around someone or being in a familiar place can make a big difference. You don't have to go through things alone.")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)

                        // Contact list
                        if !viewModel.safetyPlan.contacts.isEmpty {
                            VStack(spacing: MindAlertTheme.Spacing._8) {
                                ForEach(viewModel.safetyPlan.contacts) { contact in
                                    ContactCard(
                                        name: contact.name,
                                        phoneNumber: contact.phoneNumber,
                                        onDelete: {
                                            if let idx = viewModel.safetyPlan.contacts.firstIndex(where: { $0.id == contact.id }) {
                                                viewModel.removeContact(at: idx)
                                            }
                                        }
                                    )
                                }
                            }
                        }

                        // Add buttons
                        VStack(spacing: MindAlertTheme.Spacing._8) {
                            Button {
                                showContactPicker = true
                            } label: {
                                HStack(spacing: MindAlertTheme.Spacing._8) {
                                    Image(systemName: "person.crop.circle.fill.badge.plus")
                                    Text("Import from Contacts")
                                }
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.mindGreen)
                                .frame(maxWidth: .infinity)
                                .padding(MindAlertTheme.Spacing._16)
                                .background(MindAlertTheme.whiteGreen)
                                .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                            }
                            .buttonStyle(.plain)
                        }

                        // Default help message
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("Default Help Message to Send")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)
                            Text("Hi, I'm really struggling right now and need some support. I added you as a trusted contact in my safety plan app. Can you please check in with me?")
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(MindAlertTheme.Spacing._16)
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
                    onPrimary: { router.navigate(to: .professionalSupport) }
                )
            }
        }
        .sheet(isPresented: $showContactPicker) {
            ContactPickerView { name, phone in
                let existingPhones = Set(viewModel.safetyPlan.contacts.map { $0.phoneNumber })
                if !existingPhones.contains(phone) {
                    viewModel.addContact(name: name, phoneNumber: phone)
                }
            }
        }
    }
}

#Preview {
    PeopleThatHelpView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
