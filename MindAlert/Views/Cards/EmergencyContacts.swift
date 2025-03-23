//
//  EmergencyContacts.swift
//  MindAlert
//
//  Created by DASHAN LIAO on 4/17/22.
//

import SwiftUI

struct EmergencyContacts: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var showingAddContact = false
    @State private var newContactName = ""
    @State private var newContactPhone = ""
    @State var selection: Int? = nil
    @State private var emergencyMessage = "Hello (name). I am not ok right now. I already contacted professional services, but you can help me by going through this process with me. Are you available to help me right now?"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("inprogress-2")
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 1, green: 1, blue: 1))
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 15) {
                                    Image(systemName: "person.2.wave.2")
                                        .foregroundColor(Color("MindGreen"))
                                        .font(.system(size: 36, weight: .regular))
                                    Text("Emergency Contacts")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color("MindBlack"))
                                }
                                Spacer()
                                ScrollView {
                                    VStack(alignment:.leading) {
                                        Text("Well done \(viewModel.safetyPlan.name),\nlet's set up your emergency contacts")
                                            .foregroundColor(Color("MindBlack"))
                                            .font(.system(size: 32, weight: .semibold))
                                        
                                        // Contact circles
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 20) {
                                                // Existing contacts
                                                ForEach(viewModel.safetyPlan.contacts.indices, id: \.self) { index in
                                                    let contact = viewModel.safetyPlan.contacts[index]
                                                    let initials = String(contact.name.prefix(2).uppercased())
                                                    
                                                    VStack {
                                                        Text(initials)
                                                            .frame(width: 80, height: 80, alignment: .center)
                                                            .foregroundColor(Color("MindPeachWhite"))
                                                            .background(Color("MindPeach"))
                                                            .cornerRadius(40)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 40)
                                                                    .stroke(Color("MindPeach"), lineWidth: 3)
                                                            )
                                                            .font(.system(size: 36, weight: .medium))
                                                        
                                                        Text(contact.name)
                                                            .font(.system(size: 14, weight: .medium))
                                                            .foregroundColor(Color("MindBlack"))
                                                            .lineLimit(1)
                                                    }
                                                    .contextMenu {
                                                        Button(action: {
                                                            viewModel.removeContact(at: index)
                                                        }) {
                                                            Label("Remove", systemImage: "trash")
                                                        }
                                                    }
                                                }
                                                
                                                // Add new contact button
                                                Button(action: {
                                                    showingAddContact = true
                                                }) {
                                                    Text("\(Image(systemName: "plus"))")
                                                        .frame(width: 80, height: 80, alignment: .center)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color("MindLightPeach"), lineWidth: 3)
                                                        )
                                                        .font(.system(size: 36, weight: .medium))
                                                        .foregroundColor(Color("MindLightPeach"))
                                                }
                                            }
                                            .padding(.vertical, 10)
                                        }
                                        
                                        Divider()
                                        
                                        VStack(alignment: .leading) {
                                            Text("Emergency Message:")
                                                .font(.system(size: 20, weight: .bold))
                                            TextEditor(text: $emergencyMessage)
                                                .font(.system(size: 20, weight: .regular))
                                                .frame(minHeight: 200)
                                                .padding()
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color("MindPeach"), style: StrokeStyle(lineWidth: 3))
                                                )
                                                .onChange(of: emergencyMessage) { _ in
                                                    // You could add a function to save the emergency message as well
                                                }
                                        }
                                        .padding(5)
                                    }
                                }
                                
                                Spacer()
                                HStack {
                                    Spacer()
                                    NavigationLink(
                                        destination: EmergencyServicesView(viewModel: viewModel), tag: 1, selection: $selection) {
                                        Button("Next") {
                                            self.selection = 1
                                        }
                                        .buttonStyle(GreenButton())
                                    }
                                    Spacer()
                                }
                            }
                            .padding(25)
                        }
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
            .hiddenNavigationBarStyle()
        }
        .hiddenNavigationBarStyle()
    }
}

// Helper view to add a new contact
struct AddContactView: View {
    @Binding var isPresented: Bool
    @Binding var name: String
    @Binding var phone: String
    var saveAction: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Details")) {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Add Contact")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    saveAction()
                    isPresented = false
                }
            )
        }
    }
}
