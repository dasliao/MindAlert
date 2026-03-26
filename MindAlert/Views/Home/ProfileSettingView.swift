import SwiftUI

/// Profile & settings screen. Matches Play page: ProfileSetting.
/// Variables: userName, userEmail, copingStrategies, trustContactsArray,
///            professionalContactsArray, currTrustContact, currProfessionalContact, emergencyServices
struct ProfileSettingView: View {
    @EnvironmentObject var viewModel: SafetyPlanViewModel
    @EnvironmentObject var router: AppRouter

    @State private var editingName = false
    @State private var editingEmail = false
    @State private var nameText = ""
    @State private var emailText = ""
    @State private var showAddTrustContact = false
    @State private var showAddProfessionalContact = false
    @State private var showResetConfirmation = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "Profile", variant: .titleOnly)
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(spacing: MindAlertTheme.Spacing._24) {
                        // Profile section
                        settingsSection("My Profile") {
                            editableField(
                                label: "Name",
                                value: viewModel.safetyPlan.name,
                                isEditing: $editingName,
                                text: $nameText,
                                onSave: { viewModel.setName(nameText) }
                            )
                            Divider().padding(.leading, MindAlertTheme.Spacing._16)
                            editableField(
                                label: "Email",
                                value: viewModel.safetyPlan.email.isEmpty ? "Not set" : viewModel.safetyPlan.email,
                                isEditing: $editingEmail,
                                text: $emailText,
                                onSave: { viewModel.setEmail(emailText) }
                            )
                        }

                        // Coping strategies section
                        settingsSection("Coping Strategies") {
                            if viewModel.safetyPlan.strategies.isEmpty {
                                emptyRow("No strategies added yet")
                            } else {
                                ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { idx in
                                    if idx > 0 { Divider().padding(.leading, MindAlertTheme.Spacing._16) }
                                    StrategySettingCard(
                                        number: idx + 1,
                                        text: viewModel.safetyPlan.strategies[idx],
                                        onDelete: { viewModel.removeStrategy(at: idx) }
                                    )
                                }
                            }
                        }

                        // Trust contacts section
                        settingsSection("People That Help") {
                            if viewModel.safetyPlan.contacts.isEmpty {
                                emptyRow("No contacts added yet")
                            } else {
                                ForEach(viewModel.safetyPlan.contacts) { contact in
                                    if viewModel.safetyPlan.contacts.first?.id != contact.id {
                                        Divider().padding(.leading, MindAlertTheme.Spacing._16)
                                    }
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
                            Divider().padding(.leading, MindAlertTheme.Spacing._16)
                            Button {
                                showAddTrustContact = true
                            } label: {
                                Label("Add Contact", systemImage: "person.badge.plus")
                                    .font(.maBoldBody)
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(MindAlertTheme.Spacing._16)
                            }
                            .buttonStyle(.plain)
                        }

                        // Professional contacts section
                        settingsSection("Professional Support") {
                            if viewModel.safetyPlan.professionalContacts.isEmpty {
                                emptyRow("No professional contacts yet")
                            } else {
                                ForEach(viewModel.safetyPlan.professionalContacts) { contact in
                                    if viewModel.safetyPlan.professionalContacts.first?.id != contact.id {
                                        Divider().padding(.leading, MindAlertTheme.Spacing._16)
                                    }
                                    ContactCard(
                                        name: contact.name,
                                        phoneNumber: contact.phoneNumber,
                                        onDelete: {
                                            if let idx = viewModel.safetyPlan.professionalContacts.firstIndex(where: { $0.id == contact.id }) {
                                                viewModel.removeProfessionalContact(at: idx)
                                            }
                                        }
                                    )
                                }
                            }
                            Divider().padding(.leading, MindAlertTheme.Spacing._16)
                            Button {
                                showAddProfessionalContact = true
                            } label: {
                                Label("Add Professional", systemImage: "person.badge.plus")
                                    .font(.maBoldBody)
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(MindAlertTheme.Spacing._16)
                            }
                            .buttonStyle(.plain)
                        }

                        // Emergency service section
                        settingsSection("Emergency Service") {
                            HStack(spacing: MindAlertTheme.Spacing._12) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                    .frame(width: 24)
                                Text(viewModel.safetyPlan.emergencyService)
                                    .font(.maBoldBody)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                                Spacer()
                            }
                            .padding(MindAlertTheme.Spacing._16)
                        }

                        // Debug: Rerun onboarding
                        settingsSection("Developer") {
                            Button {
                                showResetConfirmation = true
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.counterclockwise")
                                        .foregroundColor(MindAlertTheme.mindPeach)
                                    Text("Rerun Onboarding")
                                        .font(.maBoldBody)
                                        .foregroundColor(MindAlertTheme.mindPeach)
                                    Spacer()
                                }
                                .padding(MindAlertTheme.Spacing._16)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._48)
                }
            }
        }
        .sheet(isPresented: $showAddTrustContact) {
            ContactPickerView { name, phone in
                let existingPhones = Set(viewModel.safetyPlan.contacts.map { $0.phoneNumber })
                if !existingPhones.contains(phone) {
                    viewModel.addContact(name: name, phoneNumber: phone)
                }
            }
        }
        .sheet(isPresented: $showAddProfessionalContact) {
            ContactPickerView { name, phone in
                let existingPhones = Set(viewModel.safetyPlan.professionalContacts.map { $0.phoneNumber })
                if !existingPhones.contains(phone) {
                    viewModel.addProfessionalContact(name: name, phoneNumber: phone)
                }
            }
        }
        .confirmationDialog("Rerun Onboarding?", isPresented: $showResetConfirmation, titleVisibility: .visible) {
            Button("Reset & Restart", role: .destructive) {
                viewModel.clearSavedPlan()
                router.resetOnboarding()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will clear your safety plan and restart onboarding.")
        }
        .onAppear {
            nameText = viewModel.safetyPlan.name
            emailText = viewModel.safetyPlan.email
        }
    }

    @ViewBuilder
    private func settingsSection<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
            Text(title)
                .font(.maCaption)
                .foregroundColor(MindAlertTheme.textSecondary)
                .padding(.leading, MindAlertTheme.Spacing._4)

            VStack(spacing: 0) {
                content()
            }
            .background(MindAlertTheme.white)
            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        }
    }

    @ViewBuilder
    private func editableField(label: String, value: String, isEditing: Binding<Bool>, text: Binding<String>, onSave: @escaping () -> Void) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Text(label)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textSecondary)
                .frame(width: 60, alignment: .leading)

            if isEditing.wrappedValue {
                TextField(label, text: text)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textPrimary)
            } else {
                Text(value)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textPrimary)
            }

            Spacer()

            Button {
                if isEditing.wrappedValue {
                    onSave()
                    isEditing.wrappedValue = false
                } else {
                    isEditing.wrappedValue = true
                }
            } label: {
                Text(isEditing.wrappedValue ? "Save" : "Edit")
                    .font(.maCaption)
                    .foregroundColor(MindAlertTheme.mindGreen)
            }
        }
        .padding(MindAlertTheme.Spacing._16)
    }

    @ViewBuilder
    private func emptyRow(_ text: String) -> some View {
        Text(text)
            .font(.maCaption)
            .foregroundColor(MindAlertTheme.textTertiary)
            .padding(MindAlertTheme.Spacing._16)
    }
}

#Preview {
    ProfileSettingView()
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex Johnson")
            vm.addStrategy("Listen to music")
            vm.addContact(name: "Jamie Lee", phoneNumber: "555-1234")
            return vm
        }())
        .environmentObject(AppRouter())
}
