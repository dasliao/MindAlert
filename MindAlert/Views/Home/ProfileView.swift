import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onRerunOnboarding: () -> Void
    @State private var showRerunConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                    Text("Your Safety Plan")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.top, MindAlertTheme.Spacing._8)

                    // Name
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                        Label("Name", systemImage: "person")
                            .font(.maCaption)
                            .foregroundStyle(MindAlertTheme.textSecondary)
                        Text(viewModel.safetyPlan.name)
                            .font(.maHeadline)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Strategies
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        Label("Coping Strategies", systemImage: "tray.full")
                            .font(.maCaption)
                            .foregroundStyle(MindAlertTheme.textSecondary)

                        if viewModel.safetyPlan.strategies.isEmpty {
                            Text("No strategies added")
                                .foregroundStyle(MindAlertTheme.textTertiary)
                                .italic()
                                .font(.maCaption)
                        } else {
                            ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                                strategyCard(number: index + 1, text: viewModel.safetyPlan.strategies[index])
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Contacts
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                        Label("Emergency Contacts", systemImage: "person.2.wave.2")
                            .font(.maCaption)
                            .foregroundStyle(MindAlertTheme.textSecondary)

                        if viewModel.safetyPlan.contacts.isEmpty {
                            Text("No contacts added")
                                .foregroundStyle(MindAlertTheme.textTertiary)
                                .italic()
                                .font(.maCaption)
                        } else {
                            ForEach(viewModel.safetyPlan.contacts) { contact in
                                HStack {
                                    Text(String(contact.name.prefix(2)).uppercased())
                                        .font(.maTabCaption)
                                        .foregroundStyle(MindAlertTheme.staticWhite)
                                        .frame(width: 36, height: 36)
                                        .background(MindAlertTheme.mindGreen)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                                        Text(contact.name)
                                            .font(.maBoldBody)
                                            .foregroundStyle(MindAlertTheme.textPrimary)
                                        Text(contact.phoneNumber)
                                            .font(.maCaption)
                                            .foregroundStyle(MindAlertTheme.textSecondary)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Emergency Service
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                        Label("Emergency Service", systemImage: "cross.case")
                            .font(.maCaption)
                            .foregroundStyle(MindAlertTheme.textSecondary)
                        Text(viewModel.safetyPlan.emergencyService)
                            .font(.maHeadline)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()

                    // Debug
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                        Label("Debug", systemImage: "wrench.and.screwdriver")
                            .font(.maCaption)
                            .foregroundStyle(MindAlertTheme.textSecondary)
                        Button("Rerun Onboarding") {
                            showRerunConfirmation = true
                        }
                        .font(.maBoldBody)
                        .foregroundStyle(MindAlertTheme.mindPeach)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .mindAlertCard()
                }
                .padding(MindAlertTheme.Spacing._24)
            }
            .background(MindAlertTheme.background.ignoresSafeArea())
            .alert("Rerun Onboarding?", isPresented: $showRerunConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Rerun", role: .destructive) {
                    onRerunOnboarding()
                }
            } message: {
                Text("This will clear your current safety plan and restart the onboarding flow.")
            }
        }
    }

    private func strategyCard(number: Int, text: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Text("\(number)")
                .font(.maCaption)
                .foregroundStyle(MindAlertTheme.mindLightGreen)
                .frame(width: 24)
            Text(text)
                .font(.maBoldBody)
                .foregroundStyle(MindAlertTheme.textPrimary)
        }
        .padding(.vertical, MindAlertTheme.Spacing._4)
    }
}
