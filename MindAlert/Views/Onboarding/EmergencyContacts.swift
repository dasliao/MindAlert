import SwiftUI
import Contacts

struct EmergencyContacts: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var showingContactPicker = false
    @State private var showingEditMessage = false
    @State private var phoneContacts: [PhoneContact] = []
    @State private var selectedContactIDs: Set<String> = []
    @State private var contactsAccessGranted = false
    var onNext: () -> Void

    struct PhoneContact: Identifiable {
        let id: String
        let name: String
        let phoneNumber: String
        let initials: String
    }

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 2)
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image(systemName: "person.2.wave.2")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 36, weight: .regular))
                    Text("Emergency Contacts")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindBlack)
                }

                Divider()

                VStack(alignment: .leading) {
                    Text("Well done \(viewModel.safetyPlan.name),")
                    Text("Let's set up your emergency contacts")
                }
                .foregroundStyle(MindAlertTheme.mindBlack)
                .font(.system(size: 32, weight: .semibold))

                // Contact avatars row
                if !viewModel.safetyPlan.contacts.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.safetyPlan.contacts) { contact in
                                VStack(spacing: 4) {
                                    Text(String(contact.name.prefix(2)).uppercased())
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(.white)
                                        .frame(width: 50, height: 50)
                                        .background(MindAlertTheme.mindGreen)
                                        .clipShape(Circle())
                                    Text(contact.name)
                                        .font(.system(size: 12))
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                            }

                            // Add button
                            Button {
                                showingContactPicker = true
                            } label: {
                                Image(systemName: "person.badge.plus")
                                    .font(.system(size: 20))
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle()
                                            .stroke(MindAlertTheme.mindLightGreen, lineWidth: 1.5)
                                    )
                            }
                        }
                    }
                } else {
                    Button {
                        showingContactPicker = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "person.badge.plus")
                            Text("Add Contact")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .overlay(
                            Capsule()
                                .stroke(MindAlertTheme.mindGreen, lineWidth: 1.5)
                        )
                    }
                }

                // Message template card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Message Template:")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(MindAlertTheme.mindPeach)

                    Text(viewModel.safetyPlan.resolvedEmergencyMessage)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(MindAlertTheme.mindBlack)

                    Button {
                        showingEditMessage = true
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "square.and.pencil")
                            Text("Edit Message")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(MindAlertTheme.mindPeach)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .overlay(
                            Capsule()
                                .stroke(MindAlertTheme.mindPeach, lineWidth: 1.5)
                        )
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(MindAlertTheme.cardBackground)
                )

                Spacer()

                HStack {
                    Spacer()
                    Button("Confirm") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
            }
            .padding(20)
            .sheet(isPresented: $showingContactPicker) {
                ContactPickerSheet(
                    viewModel: viewModel,
                    isPresented: $showingContactPicker
                )
            }
            .sheet(isPresented: $showingEditMessage) {
                EditMessageSheet(
                    viewModel: viewModel,
                    isPresented: $showingEditMessage
                )
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Contact Picker Sheet
struct ContactPickerSheet: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @Binding var isPresented: Bool
    @State private var phoneContacts: [EmergencyContacts.PhoneContact] = []
    @State private var selectedIDs: Set<String> = []
    @State private var permissionDenied = false

    var body: some View {
        NavigationStack {
            Group {
                if permissionDenied {
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .font(.system(size: 50))
                            .foregroundStyle(.secondary)
                        Text("Contacts access is required to add emergency contacts.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                        Text("Please enable it in Settings > Privacy > Contacts.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .foregroundStyle(.tertiary)
                    }
                    .padding()
                } else if phoneContacts.isEmpty {
                    ProgressView("Loading contacts...")
                } else {
                    List {
                        Section("Choose the Contacts") {
                            ForEach(phoneContacts) { contact in
                                Button {
                                    toggleSelection(contact)
                                } label: {
                                    HStack(spacing: 14) {
                                        // Avatar
                                        Text(contact.initials)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundStyle(.white)
                                            .frame(width: 44, height: 44)
                                            .background(MindAlertTheme.mindGreen)
                                            .clipShape(Circle())

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(contact.name)
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundStyle(MindAlertTheme.mindBlack)
                                            Text(contact.phoneNumber)
                                                .font(.system(size: 14))
                                                .foregroundStyle(.secondary)
                                        }

                                        Spacer()

                                        Image(systemName: selectedIDs.contains(contact.id) ? "checkmark.circle.fill" : "circle")
                                            .foregroundStyle(MindAlertTheme.mindGreen)
                                            .font(.system(size: 24))
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Contacts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        addSelectedContacts()
                        isPresented = false
                    }
                    .disabled(selectedIDs.isEmpty)
                }
            }
        }
        .onAppear {
            loadContacts()
        }
    }

    private func toggleSelection(_ contact: EmergencyContacts.PhoneContact) {
        if selectedIDs.contains(contact.id) {
            selectedIDs.remove(contact.id)
        } else {
            selectedIDs.insert(contact.id)
        }
    }

    private func addSelectedContacts() {
        let existingPhones = Set(viewModel.safetyPlan.contacts.map { $0.phoneNumber })
        for contact in phoneContacts where selectedIDs.contains(contact.id) {
            if !existingPhones.contains(contact.phoneNumber) {
                viewModel.addContact(name: contact.name, phoneNumber: contact.phoneNumber)
            }
        }
    }

    private func loadContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                guard granted else {
                    permissionDenied = true
                    return
                }
                contactsAccessGranted = true
                fetchContacts(store: store)
            }
        }
    }

    @State private var contactsAccessGranted = false

    private func fetchContacts(store: CNContactStore) {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.sortOrder = .givenName

        var results: [EmergencyContacts.PhoneContact] = []
        do {
            try store.enumerateContacts(with: request) { contact, _ in
                guard let phone = contact.phoneNumbers.first?.value.stringValue else { return }
                let name = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
                guard !name.isEmpty else { return }
                let initials = String(contact.givenName.prefix(1) + contact.familyName.prefix(1)).uppercased()
                results.append(EmergencyContacts.PhoneContact(
                    id: contact.identifier,
                    name: name,
                    phoneNumber: phone,
                    initials: initials.isEmpty ? "?" : initials
                ))
            }
        } catch {
            // Handle error silently
        }

        DispatchQueue.main.async {
            phoneContacts = results
        }
    }
}

// MARK: - Edit Message Sheet
struct EditMessageSheet: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @Binding var isPresented: Bool
    @State private var messageText: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Emergency Message")) {
                    TextEditor(text: $messageText)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle("Edit Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.setEmergencyMessage(messageText)
                        isPresented = false
                    }
                }
            }
        }
        .onAppear {
            messageText = viewModel.safetyPlan.resolvedEmergencyMessage
        }
    }
}
