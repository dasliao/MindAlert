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
                VStack(spacing: 16) {
                    // Section 1: Activated confirmation
                    VStack(alignment: .leading, spacing: 12) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 40, weight: .light))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        Text("Hi \(viewModel.safetyPlan.name),\nyour \(Text("Safety Plan").foregroundStyle(MindAlertTheme.mindGreen)) is activated.")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(MindAlertTheme.mindBlack)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(20)

                    // Section 2: Contacts messaged
                    if !viewModel.safetyPlan.contacts.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("We have sent\ntext messages to")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(MindAlertTheme.mindBlack)

                            HStack(spacing: 16) {
                                ForEach(viewModel.safetyPlan.contacts) { contact in
                                    VStack(spacing: 6) {
                                        Text(String(contact.name.prefix(2)).uppercased())
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.white)
                                            .frame(width: 50, height: 50)
                                            .background(MindAlertTheme.mindGreen)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(MindAlertTheme.mindGreen, lineWidth: 2)
                                            )
                                        Text(contact.name.components(separatedBy: " ").first ?? contact.name)
                                            .font(.system(size: 12))
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 60)
                                    }
                                }
                            }
                        }
                        .padding(25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(MindAlertTheme.cardBackground)
                        .cornerRadius(20)
                    }

                    // Section 3: Help is on the way
                    VStack(alignment: .leading, spacing: 12) {
                        Text("And\nhelp is on the way...")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(MindAlertTheme.mindBlack)
                        Image(systemName: "car.side")
                            .font(.system(size: 28))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(20)

                    // Section 4: Coping strategies header
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Now\nLet's focus on your \(Text("Coping Strategies").foregroundStyle(MindAlertTheme.mindGreen)).")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(MindAlertTheme.mindBlack)
                        Image(systemName: "tray.full")
                            .font(.system(size: 28))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(20)

                    // Section 5: Activities
                    if !viewModel.safetyPlan.strategies.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 8) {
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 24))
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                            }

                            Text("Let's try these activities:")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(MindAlertTheme.mindBlack)

                            VStack(spacing: 10) {
                                ForEach(viewModel.safetyPlan.strategies, id: \.self) { strategy in
                                    strategyPill(strategy)
                                }
                            }
                        }
                        .padding(25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(MindAlertTheme.cardBackground)
                        .cornerRadius(20)
                    }
                }
                .padding()
            }
            .background(MindAlertTheme.background)
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
        .onAppear {
            sendMessagesToContacts()
        }
    }

    private func strategyPill(_ strategy: String) -> some View {
        HStack {
            Text(strategy)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)

            if strategy.lowercased().hasPrefix("http") {
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(MindAlertTheme.mindPeach)
        .cornerRadius(12)
    }

    private func sendMessagesToContacts() {
        // Auto-send SMS to all contacts when plan is activated
        for contact in viewModel.safetyPlan.contacts {
            if MFMessageComposeViewController.canSendText() {
                smsRecipient = contact.phoneNumber
                showingSMSComposer = true
                break // Show composer for first contact
            }
        }
        // Also trigger emergency service call
        if !viewModel.safetyPlan.emergencyService.isEmpty {
            viewModel.callEmergencyService()
        }
    }
}
