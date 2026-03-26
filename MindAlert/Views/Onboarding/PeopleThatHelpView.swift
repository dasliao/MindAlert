import SwiftUI

/// Onboarding step 6 of 11.
/// Matches Play page: PeopleThatHelp
/// Variables: contactString, contactArray, accessTest
struct PeopleThatHelpView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var showContactPicker = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "People That Help", onBack: { router.navigate(to: .aboutSafetyPlan) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        // Header
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("Who do you trust?")
                                .font(.maLargeTitle)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            Text("Add people you trust who can support you during a crisis. They'll receive a message when you activate your safety plan.")
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

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

                        // Add contact button
                        Button {
                            showContactPicker = true
                        } label: {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "person.badge.plus")
                                Text("Add from Contacts")
                            }
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.mindGreen)
                            .frame(maxWidth: .infinity)
                            .padding(MindAlertTheme.Spacing._16)
                            .background(MindAlertTheme.whiteGreen)
                            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                            .overlay(
                                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16)
                                    .strokeBorder(MindAlertTheme.mindGreen.opacity(0.4), lineWidth: 1.5)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Continue",
                    primaryEnabled: !viewModel.safetyPlan.contacts.isEmpty,
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
