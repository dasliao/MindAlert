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
                VStack(spacing: MindAlertTheme.Spacing._16) {
                    // Section 1: Activated confirmation
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 40, weight: .light))
                            .foregroundStyle(MindAlertTheme.mindGreen)

                        (Text("Hi \(viewModel.safetyPlan.name),\nyour ")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        + Text("Safety Plan")
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        + Text(" is activated.")
                            .foregroundStyle(MindAlertTheme.textPrimary))
                        .font(.maSplashBody)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Section 2: Contacts messaged
                    if !viewModel.safetyPlan.contacts.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                            Text("We have sent\ntext messages to")
                                .font(.maPageHeaderSmall)
                                .foregroundStyle(MindAlertTheme.textPrimary)

                            HStack(spacing: MindAlertTheme.Spacing._16) {
                                ForEach(viewModel.safetyPlan.contacts) { contact in
                                    VStack(spacing: MindAlertTheme.Spacing._4) {
                                        Text(String(contact.name.prefix(2)).uppercased())
                                            .font(.maBoldBody)
                                            .foregroundStyle(MindAlertTheme.staticWhite)
                                            .frame(width: 50, height: 50)
                                            .background(MindAlertTheme.mindGreen)
                                            .clipShape(Circle())
                                        Text(contact.name.components(separatedBy: " ").first ?? contact.name)
                                            .font(.maTabCaption)
                                            .foregroundStyle(MindAlertTheme.textSecondary)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 60)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .mindAlertCard()
                    }

                    // Section 3: Help is on the way
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        Text("And\nhelp is on the way...")
                            .font(.maPageHeaderSmall)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        Image(systemName: "car.side")
                            .font(.system(size: 28))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Section 4: Coping strategies header
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        (Text("Now\nLet's focus on your ")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        + Text("Coping Strategies")
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        + Text(".")
                            .foregroundStyle(MindAlertTheme.textPrimary))
                        .font(.maPageHeaderSmall)

                        Image(systemName: "tray.full")
                            .font(.system(size: 28))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Section 5: Activities
                    if !viewModel.safetyPlan.strategies.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 24))
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                            }

                            Text("Let's try these activities:")
                                .font(.maPageHeaderSmall)
                                .foregroundStyle(MindAlertTheme.textPrimary)

                            VStack(spacing: MindAlertTheme.Spacing._12) {
                                ForEach(viewModel.safetyPlan.strategies, id: \.self) { strategy in
                                    strategyPill(strategy)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .mindAlertCard()
                    }
                }
                .padding(MindAlertTheme.Spacing._16)
            }
            .background(MindAlertTheme.background.ignoresSafeArea())
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
                .font(.maBoldBody)
                .foregroundStyle(MindAlertTheme.staticWhite)
            Spacer()
        }
        .padding(.horizontal, MindAlertTheme.Spacing._24)
        .padding(.vertical, MindAlertTheme.Spacing._16)
        .background(
            RoundedRectangle(cornerRadius: MindAlertTheme.Radius._12)
                .fill(MindAlertTheme.mindPeach)
        )
    }

    private func sendMessagesToContacts() {
        for contact in viewModel.safetyPlan.contacts {
            if MFMessageComposeViewController.canSendText() {
                smsRecipient = contact.phoneNumber
                showingSMSComposer = true
                break
            }
        }
        if !viewModel.safetyPlan.emergencyService.isEmpty {
            viewModel.callEmergencyService()
        }
    }
}
