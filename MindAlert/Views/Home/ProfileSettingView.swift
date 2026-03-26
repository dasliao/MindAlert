import SwiftUI

/// Profile & settings screen. Matches Play page: ProfileSetting.
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
                        // Profile header with icon
                        VStack(spacing: MindAlertTheme.Spacing._12) {
                            Circle()
                                .fill(MindAlertTheme.whiteGreen)
                                .frame(width: 72, height: 72)
                                .overlay(
                                    Text(profileInitials)
                                        .font(.maPageHeaderSmall)
                                        .foregroundColor(MindAlertTheme.mindGreen)
                                )

                            VStack(spacing: MindAlertTheme.Spacing._4) {
                                Text(viewModel.safetyPlan.name)
                                    .font(.maHeadline)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                                Text(viewModel.safetyPlan.email.isEmpty ? "email@example.com" : viewModel.safetyPlan.email)
                                    .font(.maCaption)
                                    .foregroundColor(MindAlertTheme.textSecondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, MindAlertTheme.Spacing._16)

                        // APP SETTING
                        settingsSection("APP SETTING") {
                            HStack {
                                Text("Appearance")
                                    .font(.maBoldBody)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                                Spacer()
                                // Segmented control placeholder: Auto / Light / Dark
                                Picker("", selection: .constant(0)) {
                                    Text("Auto").tag(0)
                                    Text("Light").tag(1)
                                    Text("Dark").tag(2)
                                }
                                .pickerStyle(.segmented)
                                .frame(width: 180)
                            }
                            .padding(MindAlertTheme.Spacing._16)
                        }

                        // COPING STRATEGIES
                        settingsSection("COPING STRATEGIES") {
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

                        // TRUST CONTACTS
                        settingsSection("TRUST CONTACTS") {
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
                            importButton { showAddTrustContact = true }
                        }

                        // PROFESSIONALS CONTACTS
                        settingsSection("PROFESSIONALS CONTACTS") {
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
                            importButton { showAddProfessionalContact = true }
                        }

                        // EMERGENCY SERVICES
                        settingsSection("EMERGENCY SERVICES") {
                            HStack(spacing: MindAlertTheme.Spacing._12) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                    .frame(width: 24)
                                Text(viewModel.safetyPlan.emergencyService.isEmpty ? "911" : viewModel.safetyPlan.emergencyService)
                                    .font(.maBoldBody)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                                Spacer()
                            }
                            .padding(MindAlertTheme.Spacing._16)
                        }

                        // Developer / Rerun onboarding
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

    private var profileInitials: String {
        let parts = viewModel.safetyPlan.name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1)) + String(parts[1].prefix(1))
        }
        return String(viewModel.safetyPlan.name.prefix(2)).uppercased()
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
    private func importButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: MindAlertTheme.Spacing._8) {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                Text("Import from Contacts")
            }
            .font(.maBoldBody)
            .foregroundColor(MindAlertTheme.mindGreen)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(MindAlertTheme.Spacing._16)
        }
        .buttonStyle(.plain)
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
