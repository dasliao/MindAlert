import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Safety Plan")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.top)

                    // Name
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Name", systemImage: "person")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.secondary)
                        Text(viewModel.safetyPlan.name)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)

                    // Strategies
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Coping Strategies", systemImage: "tray.full")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.secondary)

                        if viewModel.safetyPlan.strategies.isEmpty {
                            Text("No strategies added")
                                .foregroundStyle(.tertiary)
                                .italic()
                        } else {
                            ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                                Text("\(index + 1). \(viewModel.safetyPlan.strategies[index])")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)

                    // Contacts
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Emergency Contacts", systemImage: "person.2.wave.2")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.secondary)

                        if viewModel.safetyPlan.contacts.isEmpty {
                            Text("No contacts added")
                                .foregroundStyle(.tertiary)
                                .italic()
                        } else {
                            ForEach(viewModel.safetyPlan.contacts) { contact in
                                HStack {
                                    Text(contact.name)
                                        .font(.system(size: 18, weight: .semibold))
                                    Spacer()
                                    Text(contact.phoneNumber)
                                        .font(.system(size: 16))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)

                    // Emergency Service
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Emergency Service", systemImage: "cross.case")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.secondary)
                        Text(viewModel.safetyPlan.emergencyService)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MindAlertTheme.cardBackground)
                    .cornerRadius(15)
                }
                .padding()
            }
            .background(MindAlertTheme.background)
        }
    }
}
