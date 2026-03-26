import SwiftUI

/// Onboarding step 4 of 11.
/// Matches Play page: InfoDisclaimer (termAgreed: Bool)
struct InfoDisclaimerView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var agreed = false
    @State private var showPrivacy = false
    @State private var showTerms = false

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "Information & Disclaimer", onBack: { router.navigate(to: .name) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        disclaimerCard(
                            icon: "heart.text.square.fill",
                            title: "Mental Health Support",
                            body: "MindAlert is designed to support you during a mental health crisis by helping you access your safety plan quickly. This app is not a substitute for professional mental health care."
                        )

                        disclaimerCard(
                            icon: "exclamationmark.shield.fill",
                            title: "Emergency Situations",
                            body: "If you are in immediate danger, please call 911 or your local emergency services immediately. MindAlert is a supplementary tool, not an emergency response system."
                        )

                        disclaimerCard(
                            icon: "lock.fill",
                            title: "Your Privacy",
                            body: "All your safety plan data is stored locally on your device. We do not collect, transmit, or share any of your personal information."
                        )

                        // Agreement checkbox
                        Button {
                            agreed.toggle()
                        } label: {
                            HStack(alignment: .top, spacing: MindAlertTheme.Spacing._12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: MindAlertTheme.Radius._4)
                                        .strokeBorder(agreed ? MindAlertTheme.mindGreen : MindAlertTheme.borderSeparator, lineWidth: 1.5)
                                        .frame(width: 22, height: 22)
                                    if agreed {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(MindAlertTheme.mindGreen)
                                    }
                                }
                                .padding(.top, 1)

                                Group {
                                    Text("I agree to the ")
                                        .foregroundColor(MindAlertTheme.textSecondary) +
                                    Text("Privacy Policy")
                                        .foregroundColor(MindAlertTheme.mindGreen)
                                        .underline() +
                                    Text(" and ")
                                        .foregroundColor(MindAlertTheme.textSecondary) +
                                    Text("Terms & Conditions")
                                        .foregroundColor(MindAlertTheme.mindGreen)
                                        .underline() +
                                    Text(" and understand that this app does not replace professional mental health care.")
                                        .foregroundColor(MindAlertTheme.textSecondary)
                                }
                                .font(.maCaption)
                                .multilineTextAlignment(.leading)
                            }
                        }
                        .buttonStyle(.plain)

                        // Links
                        HStack(spacing: MindAlertTheme.Spacing._24) {
                            Button("Privacy Policy") { showPrivacy = true }
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.mindGreen)
                            Button("Terms & Conditions") { showTerms = true }
                                .font(.maCaption)
                                .foregroundColor(MindAlertTheme.mindGreen)
                        }
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Continue",
                    primaryEnabled: agreed,
                    onPrimary: {
                        viewModel.setTermAgreed(true)
                        router.navigate(to: .aboutSafetyPlan)
                    }
                )
            }
        }
        .sheet(isPresented: $showPrivacy) {
            PrivacyPolicyView()
        }
        .sheet(isPresented: $showTerms) {
            TermsConditionView()
        }
        .onAppear {
            agreed = viewModel.safetyPlan.termAgreed
        }
    }

    @ViewBuilder
    private func disclaimerCard(icon: String, title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
            HStack(spacing: MindAlertTheme.Spacing._8) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(MindAlertTheme.mindGreen)
                Text(title)
                    .font(.maHeadline)
                    .foregroundColor(MindAlertTheme.textPrimary)
            }
            Text(body)
                .font(.maCaption)
                .foregroundColor(MindAlertTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }
}

#Preview {
    InfoDisclaimerView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
