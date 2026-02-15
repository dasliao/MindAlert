import SwiftUI
import MessageUI

struct SafetyPlanActivatedView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingSMSComposer = false
    @State private var smsRecipient = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Safety Plan Activated")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.top)

                    // Coping Strategies Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "tray.full")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 24))
                            Text("Coping Strategies")
                                .font(.title3)
                                .fontWeight(.bold)
                        }

                        if viewModel.safetyPlan.strategies.isEmpty {
                            Text("No strategies added")
                                .foregroundStyle(.secondary)
                                .italic()
                        } else {
                            ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                    Text(viewModel.safetyPlan.strategies[index])
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding()
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)

                    // Emergency Contacts Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.2.wave.2")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 24))
                            Text("Emergency Contacts")
                                .font(.title3)
                                .fontWeight(.bold)
                        }

                        if viewModel.safetyPlan.contacts.isEmpty {
                            Text("No contacts added")
                                .foregroundStyle(.secondary)
                                .italic()
                        } else {
                            ForEach(viewModel.safetyPlan.contacts.indices, id: \.self) { index in
                                let contact = viewModel.safetyPlan.contacts[index]
                                HStack {
                                    Text(contact.name)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Button {
                                        viewModel.callContact(at: index)
                                    } label: {
                                        HStack {
                                            Text("Call")
                                            Image(systemName: "phone.fill")
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(MindAlertTheme.mindGreen, in: .rect(cornerRadius: 8))
                                        .foregroundStyle(.white)
                                        .glassEffect(.regular.tint(MindAlertTheme.greenGlassTint).interactive())
                                    }

                                    if MFMessageComposeViewController.canSendText() {
                                        Button {
                                            smsRecipient = contact.phoneNumber
                                            showingSMSComposer = true
                                        } label: {
                                            HStack {
                                                Text("SMS")
                                                Image(systemName: "message.fill")
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(MindAlertTheme.mindPeach, in: .rect(cornerRadius: 8))
                                            .foregroundStyle(.white)
                                            .glassEffect(.regular.tint(MindAlertTheme.peachGlassTint).interactive())
                                        }
                                    }
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding()
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)

                    // Emergency Services Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "cross.case")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 24))
                            Text("Emergency Services")
                                .font(.title3)
                                .fontWeight(.bold)
                        }

                        Button {
                            viewModel.callEmergencyService()
                        } label: {
                            HStack {
                                Text("Call \(viewModel.safetyPlan.emergencyService)")
                                Spacer()
                                Image(systemName: "phone.fill")
                            }
                            .padding()
                            .background(MindAlertTheme.mindPeach, in: .rect(cornerRadius: 12))
                            .foregroundStyle(.white)
                            .glassEffect(.regular.tint(MindAlertTheme.peachGlassTint).interactive())
                        }
                    }
                    .padding()
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)
                }
                .padding()
            }
            .background(MindAlertTheme.background)
            .navigationTitle("Safety Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(MindAlertTheme.mindGreen)
                }
            }
        }
        .sheet(isPresented: $showingSMSComposer) {
            if MFMessageComposeViewController.canSendText() {
                SMSComposerView(
                    recipients: [smsRecipient],
                    body: viewModel.safetyPlan.resolvedEmergencyMessage,
                    isPresented: $showingSMSComposer
                )
            }
        }
    }
}
