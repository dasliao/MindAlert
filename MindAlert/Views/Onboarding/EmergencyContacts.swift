import SwiftUI
import ContactsUI

struct EmergencyContacts: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var showingContactPicker = false
    @State private var showingEditMessage = false
    var onNext: () -> Void

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
                                .contextMenu {
                                    Button(role: .destructive) {
                                        if let idx = viewModel.safetyPlan.contacts.firstIndex(where: { $0.id == contact.id }) {
                                            viewModel.removeContact(at: idx)
                                        }
                                    } label: {
                                        Label("Remove", systemImage: "trash")
                                    }
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
                ContactPickerView { name, phone in
                    let existingPhones = Set(viewModel.safetyPlan.contacts.map { $0.phoneNumber })
                    if !existingPhones.contains(phone) {
                        viewModel.addContact(name: name, phoneNumber: phone)
                    }
                }
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

// MARK: - System Contact Picker (no permissions needed)
struct ContactPickerView: UIViewControllerRepresentable {
    var onContactSelected: (String, String) -> Void

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onContactSelected: onContactSelected)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        let onContactSelected: (String, String) -> Void

        init(onContactSelected: @escaping (String, String) -> Void) {
            self.onContactSelected = onContactSelected
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            let name = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
            let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
            if !name.isEmpty && !phone.isEmpty {
                onContactSelected(name, phone)
            }
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
