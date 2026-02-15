import SwiftUI

struct EmergencyContacts: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var showingAddContact = false
    @State private var newContactName = ""
    @State private var newContactPhone = ""
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 4, currentStep: 2)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 15) {
                            Image(systemName: "person.2.wave.2")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 36, weight: .regular))
                            Text("Emergency Contacts")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                        }
                        Spacer()
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Well done \(viewModel.safetyPlan.name),\nlet's set up your emergency contacts")
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                    .font(.system(size: 32, weight: .semibold))

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.safetyPlan.contacts.indices, id: \.self) { index in
                                            let contact = viewModel.safetyPlan.contacts[index]
                                            let initials = String(contact.name.prefix(2).uppercased())

                                            VStack {
                                                Text(initials)
                                                    .frame(width: 80, height: 80, alignment: .center)
                                                    .foregroundStyle(MindAlertTheme.mindPeachWhite)
                                                    .background(MindAlertTheme.mindPeach)
                                                    .cornerRadius(40)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(MindAlertTheme.mindPeach, lineWidth: 3)
                                                    )
                                                    .font(.system(size: 36, weight: .medium))

                                                Text(contact.name)
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                                    .lineLimit(1)
                                            }
                                            .contextMenu {
                                                Button {
                                                    viewModel.removeContact(at: index)
                                                } label: {
                                                    Label("Remove", systemImage: "trash")
                                                }
                                            }
                                        }

                                        Button {
                                            showingAddContact = true
                                        } label: {
                                            Text("\(Image(systemName: "plus"))")
                                                .frame(width: 80, height: 80, alignment: .center)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .stroke(MindAlertTheme.mindLightPeach, lineWidth: 3)
                                                )
                                                .font(.system(size: 36, weight: .medium))
                                                .foregroundStyle(MindAlertTheme.mindLightPeach)
                                        }
                                    }
                                    .padding(.vertical, 10)
                                }

                                Divider()

                                VStack(alignment: .leading) {
                                    Text("Emergency Message:")
                                        .font(.system(size: 20, weight: .bold))
                                    TextEditor(text: Binding(
                                        get: { viewModel.safetyPlan.resolvedEmergencyMessage },
                                        set: { viewModel.setEmergencyMessage($0) }
                                    ))
                                    .font(.system(size: 20, weight: .regular))
                                    .frame(minHeight: 200)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(MindAlertTheme.mindPeach, style: StrokeStyle(lineWidth: 3))
                                    )
                                }
                                .padding(5)
                            }
                        }

                        Spacer()
                        HStack {
                            Spacer()
                            Button("Next") { onNext() }
                                .buttonStyle(GreenButton())
                            Spacer()
                        }
                    }
                    .mindAlertCard()
                }
            }
            .padding(20)
            .sheet(isPresented: $showingAddContact) {
                AddContactView(
                    isPresented: $showingAddContact,
                    name: $newContactName,
                    phone: $newContactPhone,
                    saveAction: {
                        if !newContactName.isEmpty && !newContactPhone.isEmpty {
                            viewModel.addContact(name: newContactName, phoneNumber: newContactPhone)
                            newContactName = ""
                            newContactPhone = ""
                        }
                    }
                )
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct AddContactView: View {
    @Binding var isPresented: Bool
    @Binding var name: String
    @Binding var phone: String
    var saveAction: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Contact Details")) {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveAction()
                        dismiss()
                    }
                }
            }
        }
    }
}
