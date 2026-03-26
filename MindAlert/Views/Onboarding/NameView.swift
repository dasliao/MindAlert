import SwiftUI

/// Onboarding step 3 of 11.
/// Matches Play page: Name
/// TextElements: text1 (header), message (subhead), qestion1 (first name label), q2 (last name label)
struct NameView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var firstName = ""
    @State private var lastName = ""

    private var canContinue: Bool {
        !firstName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "", variant: .backOnly, onBack: { router.navigate(to: .initial) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._32) {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("What's your name?")
                                .font(.maLargeTitle)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            Text("We'll use this to personalize your experience.")
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textSecondary)
                        }

                        VStack(spacing: MindAlertTheme.Spacing._12) {
                            nameField(label: "First name", placeholder: "e.g. Alex", text: $firstName)
                            nameField(label: "Last name (optional)", placeholder: "e.g. Johnson", text: $lastName)
                        }
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._24)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Continue",
                    primaryEnabled: canContinue,
                    onPrimary: {
                        let fullName = [firstName.trimmingCharacters(in: .whitespaces),
                                        lastName.trimmingCharacters(in: .whitespaces)]
                            .filter { !$0.isEmpty }
                            .joined(separator: " ")
                        viewModel.setName(fullName)
                        router.navigate(to: .infoDisclaimer)
                    }
                )
            }
        }
        .onAppear {
            let parts = viewModel.safetyPlan.name.split(separator: " ")
            if parts.count >= 1 { firstName = String(parts[0]) }
            if parts.count >= 2 { lastName = parts.dropFirst().joined(separator: " ") }
        }
    }

    @ViewBuilder
    private func nameField(label: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
            Text(label)
                .font(.maCaption)
                .foregroundColor(MindAlertTheme.textSecondary)

            TextField(placeholder, text: text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
                .padding(MindAlertTheme.Spacing._16)
                .background(MindAlertTheme.white)
                .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
        }
    }
}

#Preview {
    NameView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
