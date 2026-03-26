import SwiftUI

/// Matches Play page: Name (Basic Info)
/// Text: "Let's get to know you better." + email field
struct NameView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var nameText = ""
    @State private var emailText = ""

    private var canContinue: Bool {
        !nameText.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "", variant: .backOnly, onBack: { router.navigate(to: .initial) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        // Header
                        Text("Let's get to know you better.")
                            .font(.maLargeTitle)
                            .foregroundColor(MindAlertTheme.textPrimary)

                        // Intro message
                        Text("Your information is used only to help you log in and access your safety plan. We don't share it with anyone.")
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.textSecondary)
                            .padding(MindAlertTheme.Spacing._16)
                            .background(MindAlertTheme.white)
                            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))

                        // Name field
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "person")
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                Text("What should we call you?")
                                    .font(.maHeadline)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                            }
                            TextField("Enter Your Name", text: $nameText)
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textPrimary)
                                .padding(MindAlertTheme.Spacing._16)
                                .background(MindAlertTheme.white)
                                .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                        }

                        // Email field
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "envelope")
                                    .foregroundColor(MindAlertTheme.mindGreen)
                                Text("What is your email?")
                                    .font(.maHeadline)
                                    .foregroundColor(MindAlertTheme.textPrimary)
                            }
                            TextField("Enter Your Email", text: $emailText)
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textPrimary)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(MindAlertTheme.Spacing._16)
                                .background(MindAlertTheme.white)
                                .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
                        }
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._24)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                // Progress buttons
                VStack(spacing: MindAlertTheme.Spacing._8) {
                    MAProgressButtons(
                        variant: .single,
                        primaryTitle: "Continue",
                        primaryEnabled: canContinue,
                        onPrimary: {
                            viewModel.setName(nameText.trimmingCharacters(in: .whitespaces))
                            viewModel.setEmail(emailText.trimmingCharacters(in: .whitespaces))
                            router.navigate(to: .infoDisclaimer)
                        }
                    )
                    Text("Already have an account? Sign in")
                        .font(.maCaption)
                        .foregroundColor(MindAlertTheme.textSecondary)
                        .padding(.bottom, MindAlertTheme.Spacing._8)
                }
            }
        }
        .onAppear {
            nameText = viewModel.safetyPlan.name
            emailText = viewModel.safetyPlan.email
        }
    }
}

#Preview {
    NameView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
