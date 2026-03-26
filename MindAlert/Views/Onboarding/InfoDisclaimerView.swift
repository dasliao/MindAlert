import SwiftUI

/// Matches Play page: InfoDisclaimer
/// Text: "Important to Know" + 3 info cards + T&C/Privacy links
struct InfoDisclaimerView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var showPrivacy = false
    @State private var showTerms = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "Important to Know", onBack: { router.navigate(to: .name) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        // Info cards
                        infoCard(
                            icon: "list.bullet.below.rectangle",
                            text: "You can complete this plan entirely on your own, with someone you trust, or your doctor or mental health provider."
                        )

                        infoCard(
                            icon: "pencil.and.list.clipboard.rtl",
                            text: "This app IS NOT replacement for professional treatment. You are deserving of help."
                        )

                        infoCard(
                            icon: "stethoscope.circle",
                            text: "We included a list of further resources you can view after setup. "
                        )

                        // Encouragement
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            Text("You're Not Alone.")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)
                            Text("If the setup feels overwhelming, try going through it with someone you trust or a mental health professional.")
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.textSecondary)
                        }
                        .padding(MindAlertTheme.Spacing._16)
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))

                        // Links
                        VStack(spacing: 0) {
                            linkRow(title: "Terms & Conditions", icon: "chevron.right") {
                                showTerms = true
                            }
                            Divider().padding(.horizontal, MindAlertTheme.Spacing._16)
                            linkRow(title: "Privacy Policy", icon: "chevron.right") {
                                showPrivacy = true
                            }
                        }
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))

                        Text("Please take a moment to read the Terms and Privacy Policy in detail before continuing.")
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textTertiary)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .verticalStack,
                    primaryTitle: "Agree & Continue",
                    secondaryTitle: "Cancel",
                    onPrimary: {
                        viewModel.setTermAgreed(true)
                        router.navigate(to: .copingStrategiesIntro)
                    },
                    onSecondary: {
                        router.navigate(to: .name)
                    }
                )
            }
        }
        .sheet(isPresented: $showPrivacy) { PrivacyPolicyView() }
        .sheet(isPresented: $showTerms) { TermsConditionView() }
    }

    @ViewBuilder
    private func infoCard(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: MindAlertTheme.Spacing._12) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(MindAlertTheme.mindGreen)
                .frame(width: 28)
            Text(text)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }

    @ViewBuilder
    private func linkRow(title: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textPrimary)
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(MindAlertTheme.textTertiary)
            }
            .padding(MindAlertTheme.Spacing._16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    InfoDisclaimerView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
