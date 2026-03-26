import SwiftUI

/// Matches Play page: ProfessionalSupport
/// Same layout as PeopleThatHelp but for professional contacts
struct ProfessionalSupportView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    var isOnboarding: Bool = true

    @State private var showContactPicker = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                if isOnboarding {
                    MANavigation(title: "Professional Support", onBack: { router.navigate(to: .peopleThatHelp) })
                        .padding(.top, MindAlertTheme.Spacing._8)
                } else {
                    MANavigation(title: "Professional Support", variant: .titleOnly)
                        .padding(.top, MindAlertTheme.Spacing._8)
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        Text("People like therapists, doctors, or counselors are trained to help you through difficult moments. Add the professionals you trust so you can reach them when you need support.")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)

                        // Contact list
                        if !viewModel.safetyPlan.professionalContacts.isEmpty {
                            VStack(spacing: MindAlertTheme.Spacing._8) {
                                ForEach(viewModel.safetyPlan.professionalContacts) { contact in
                                    ContactCard(
                                        name: contact.name,
                                        phoneNumber: contact.phoneNumber,
                                        onDelete: {
                                            if let idx = viewModel.safetyPlan.professionalContacts.firstIndex(where: { $0.id == contact.id }) {
                                                viewModel.removeProfessionalContact(at: idx)
                                            }
                                        }
                                    )
                                }
                            }
                        }

                        // Import button
                        Button {
                            showContactPicker = true
                        } label: {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                Text("Import from Contacts")
                            }
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.mindGreen)
                            .frame(maxWidth: .infinity)
                            .padding(MindAlertTheme.Spacing._16)
                            .background(MindAlertTheme.whiteGreen)
                            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                        }
                        .buttonStyle(.plain)

                        // Default help message
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("Default Help Message to Send")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)
                            Text("Hi, I'm really struggling right now and need some support. I added you as a trusted contact in my safety plan app. Can you please check in with me?")
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(MindAlertTheme.Spacing._16)
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))

                        if !isOnboarding {
                            // Crisis resources in tab mode
                            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                                Text("Crisis Resources")
                                    .font(.maHeadline)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                                crisisCard(title: "988 Suicide & Crisis Lifeline", detail: "Call or text 988", icon: "phone.fill")
                                crisisCard(title: "Crisis Text Line", detail: "Text HOME to 741741", icon: "message.fill")
                            }
                        }
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                if isOnboarding {
                    MAProgressButtons(
                        variant: .single,
                        primaryTitle: "Save & Continue",
                        onPrimary: { router.navigate(to: .emergencyServices) }
                    )
                }
            }
        }
        .sheet(isPresented: $showContactPicker) {
            ContactPickerView { name, phone in
                let existingPhones = Set(viewModel.safetyPlan.professionalContacts.map { $0.phoneNumber })
                if !existingPhones.contains(phone) {
                    viewModel.addProfessionalContact(name: name, phoneNumber: phone)
                }
            }
        }
    }

    @ViewBuilder
    private func crisisCard(title: String, detail: String, icon: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(MindAlertTheme.mindGreen)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                Text(title).font(.maBoldBody).foregroundColor(MindAlertTheme.textPrimary)
                Text(detail).font(.maCaption).foregroundColor(MindAlertTheme.textSecondary)
            }
            Spacer()
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._12))
    }
}

#Preview {
    ProfessionalSupportView(isOnboarding: true)
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
