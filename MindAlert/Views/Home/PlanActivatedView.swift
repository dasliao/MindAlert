import SwiftUI
import MessageUI

/// Displayed when the panic button is held for 3 seconds.
/// Matches Play page: PlanActivated
struct PlanActivatedView: View {
    @EnvironmentObject var viewModel: SafetyPlanViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var checkedStrategies: Set<Int> = []
    @State private var showSMS = false
    @State private var smsRecipient = ""

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    // Header
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                        Text("Hi \(viewModel.safetyPlan.name)")
                            .font(.maLargeTitle)
                            .foregroundColor(MindAlertTheme.textPrimary)
                        Text("Your Safety Plan is now active.")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.mindGreen)
                        Text("You're not alone — take your time and start with what feels most helpful.")
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, MindAlertTheme.Spacing._16)

                    // Coping Strategies
                    if !viewModel.safetyPlan.strategies.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                            Text("Coping Strategies.")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)
                            Text("Check the ones you've tried to keep track on your effort")
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.textSecondary)

                            VStack(spacing: MindAlertTheme.Spacing._8) {
                                ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { idx in
                                    strategyCheckRow(index: idx, text: viewModel.safetyPlan.strategies[idx])
                                }
                            }
                        }
                    }

                    // Trust Contacts
                    if !viewModel.safetyPlan.contacts.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "person.2.wave.2.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                Text("Reach out.")
                                    .font(.maHeadline)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                            }
                            Text("Try to contact the people you trust for help. Send them a message or give them a call.")
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)

                            VStack(spacing: MindAlertTheme.Spacing._8) {
                                ForEach(viewModel.safetyPlan.contacts.indices, id: \.self) { idx in
                                    activatedContactCard(
                                        name: viewModel.safetyPlan.contacts[idx].name,
                                        phone: viewModel.safetyPlan.contacts[idx].phoneNumber,
                                        onCall: { viewModel.callContact(at: idx) },
                                        onMessage: {
                                            smsRecipient = viewModel.safetyPlan.contacts[idx].phoneNumber
                                            showSMS = true
                                        }
                                    )
                                }
                            }
                        }
                    }

                    // Professional Help
                    if !viewModel.safetyPlan.professionalContacts.isEmpty {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "stethoscope")
                                    .font(.system(size: 18))
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                Text("Professional Help.")
                                    .font(.maHeadline)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                            }
                            Text("Try to contact the people you trust for help. Send them a message or give them a call.")
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)

                            VStack(spacing: MindAlertTheme.Spacing._8) {
                                ForEach(viewModel.safetyPlan.professionalContacts.indices, id: \.self) { idx in
                                    activatedContactCard(
                                        name: viewModel.safetyPlan.professionalContacts[idx].name,
                                        phone: viewModel.safetyPlan.professionalContacts[idx].phoneNumber,
                                        onCall: { viewModel.callProfessionalContact(at: idx) },
                                        onMessage: {
                                            smsRecipient = viewModel.safetyPlan.professionalContacts[idx].phoneNumber
                                            showSMS = true
                                        }
                                    )
                                }
                            }
                        }
                    }

                    // Feeling Better?
                    VStack(spacing: MindAlertTheme.Spacing._12) {
                        HStack(spacing: MindAlertTheme.Spacing._8) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 18))
                                .foregroundColor(MindAlertTheme.mindGreen)
                            Text("Feeling Better?")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text("If you are feeling better? deactivate your Safety Plan at anytime.")
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)

                        MAButton(title: "Deactivate Safety Plan", style: .secondary) {
                            dismiss()
                        }
                    }

                    // Emergency Service Actions
                    VStack(spacing: MindAlertTheme.Spacing._8) {
                        if viewModel.safetyPlan.emergencyService == "911" || viewModel.safetyPlan.emergencyService.isEmpty {
                            emergencyCallButton(service: "911", subtitle: "Emergency Services") {
                                viewModel.callEmergencyService()
                            }
                        }
                        if viewModel.safetyPlan.emergencyService == "988" {
                            emergencyCallButton(service: "988", subtitle: "Suicide & Crisis Lifeline") {
                                if let url = URL(string: "tel://988") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)
                .padding(.bottom, MindAlertTheme.Spacing._48)
            }
        }
        .onAppear {
            HapticManager.shared.playLongHaptic()
        }
        .sheet(isPresented: $showSMS) {
            if MFMessageComposeViewController.canSendText() {
                SMSComposerView(
                    recipients: [smsRecipient],
                    body: "Hi, I'm really struggling right now and need some support. I added you as a trusted contact in my safety plan app. Can you please check in with me?",
                    isPresented: $showSMS
                )
            }
        }
    }

    // MARK: - Strategy Check Row

    @ViewBuilder
    private func strategyCheckRow(index: Int, text: String) -> some View {
        Button {
            if checkedStrategies.contains(index) {
                checkedStrategies.remove(index)
            } else {
                checkedStrategies.insert(index)
            }
        } label: {
            HStack(spacing: MindAlertTheme.Spacing._12) {
                Image(systemName: checkedStrategies.contains(index) ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(checkedStrategies.contains(index) ? MindAlertTheme.mindGreen : MindAlertTheme.textTertiary)

                Text(text)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textPrimary)
                    .strikethrough(checkedStrategies.contains(index))

                Spacer()
            }
            .padding(MindAlertTheme.Spacing._16)
            .background(MindAlertTheme.white)
            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Activated Contact Card with Call + Message

    @ViewBuilder
    private func activatedContactCard(name: String, phone: String, onCall: @escaping () -> Void, onMessage: @escaping () -> Void) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            // Avatar
            Circle()
                .fill(MindAlertTheme.whiteGreen)
                .frame(width: 44, height: 44)
                .overlay(
                    Text(initials(for: name))
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.mindGreen)
                )

            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                Text(name)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textPrimary)
                Text(phone)
                    .font(.maCaption)
                    .foregroundColor(MindAlertTheme.textSecondary)
            }

            Spacer()

            // Message button
            Button(action: onMessage) {
                Image(systemName: "message.badge.fill")
                    .font(.system(size: 16))
                    .foregroundColor(MindAlertTheme.mindGreen)
                    .frame(width: 40, height: 40)
                    .background(MindAlertTheme.whiteGreen)
                    .clipShape(Circle())
            }

            // Call button
            Button(action: onCall) {
                Image(systemName: "phone.arrow.up.right.fill")
                    .font(.system(size: 16))
                    .foregroundColor(MindAlertTheme.staticWhite)
                    .frame(width: 40, height: 40)
                    .background(MindAlertTheme.mindGreen)
                    .clipShape(Circle())
            }
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }

    // MARK: - Emergency Call Button

    @ViewBuilder
    private func emergencyCallButton(service: String, subtitle: String, onCall: @escaping () -> Void) -> some View {
        Button(action: onCall) {
            HStack(spacing: MindAlertTheme.Spacing._12) {
                Circle()
                    .fill(MindAlertTheme.mindPeach.opacity(0.2))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(MindAlertTheme.mindPeach)
                    )

                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                    Text(service)
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.textPrimary)
                    Text(subtitle)
                        .font(.maCaption)
                        .foregroundColor(MindAlertTheme.textSecondary)
                }

                Spacer()

                Image(systemName: "phone.fill")
                    .font(.system(size: 16))
                    .foregroundColor(MindAlertTheme.staticWhite)
                    .frame(width: 40, height: 40)
                    .background(MindAlertTheme.mindPeach)
                    .clipShape(Circle())
            }
            .padding(MindAlertTheme.Spacing._16)
            .background(MindAlertTheme.white)
            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        }
        .buttonStyle(.plain)
    }

    private func initials(for name: String) -> String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1)) + String(parts[1].prefix(1))
        }
        return String(name.prefix(2)).uppercased()
    }
}

#Preview {
    PlanActivatedView()
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            vm.addStrategy("Listen to music")
            vm.addStrategy("Take a walk")
            vm.addContact(name: "Jamie Lee", phoneNumber: "555-1234")
            vm.setEmergencyService("911")
            return vm
        }())
}
