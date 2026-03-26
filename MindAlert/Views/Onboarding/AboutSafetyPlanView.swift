import SwiftUI

/// Matches Play page: AboutSafetyPlan
/// Full Stanley-Brown Safety Planning Intervention content from Play export
struct AboutSafetyPlanView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "About Safety Plan", onBack: { router.navigate(to: .infoDisclaimer) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        // Logo header
                        HStack {
                            Spacer()
                            MindAlertTitle(font: .maHeadline)
                            Spacer()
                        }
                        .padding(.vertical, MindAlertTheme.Spacing._8)

                        textCard(
                            "MindAlert is designed based on the Stanley-Brown Safety Planning Intervention, a gentle yet powerful method created by psychologists Barbara Stanley and Gregory K. Brown. This safety plan helps you prepare ahead of time, offering clear steps to follow when you feel overwhelmed or emotionally distressed. Creating this plan when you're calm makes it easier to access support exactly when you need it most."
                        )

                        sectionCard(
                            title: "Why is having a safety plan important during a crisis?",
                            body: "In moments when emotions feel intense or overwhelming, it can be hard to think clearly or make safe decisions. A personal safety plan gives you an immediate guide, gently reminding you of strategies you've chosen to help ground and comfort you. It can reduce confusion, calm your thoughts, and decrease the chances of making impulsive decisions that might hurt you."
                        )

                        // Key Components
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                            Text("Key Components of Your Safety Plan")
                                .font(.maHeadline)
                                .foregroundColor(MindAlertTheme.textPrimary)

                            componentItem(
                                title: "Recognize Your Warning Signs",
                                body: "Notice the feelings, thoughts, or situations that signal you're becoming overwhelmed or moving towards crisis."
                            )
                            componentItem(
                                title: "Coping Strategies You Can Use",
                                body: "List simple, comforting activities or distractions you can do on your own to ease difficult feelings."
                            )
                            componentItem(
                                title: "Connect With People You Trust (Family and Friends)",
                                body: "Identify family members or friends you feel comfortable reaching out to when things are tough. These should be people who make you feel understood and safe."
                            )
                            componentItem(
                                title: "Reach Out to Professionals",
                                body: "Include contacts for therapists, counselors, or mental health professionals who can support you during harder moments."
                            )
                            componentItem(
                                title: "Make Your Environment Safer",
                                body: "Think about practical steps to remove or reduce access to things you might use to harm yourself, helping your surroundings feel safer."
                            )
                        }
                        .padding(MindAlertTheme.Spacing._16)
                        .background(MindAlertTheme.white)
                        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))

                        textCard(
                            "Research consistently shows that having a safety plan can make a meaningful difference during times of crisis. People who create and actively use safety plans are more likely to seek help, find relief from overwhelming emotions, and significantly reduce the risk of harmful actions."
                        )

                        textCard(
                            "Creating your own safety plan is an empowering step towards taking care of yourself, fostering resilience, and helping you feel safer and more supported."
                        )

                        // Back button
                        Button {
                            router.navigate(to: .infoDisclaimer)
                        } label: {
                            HStack(spacing: MindAlertTheme.Spacing._8) {
                                Image(systemName: "arrow.turn.up.left")
                                Text("Back to Onboarding")
                            }
                            .font(.maBoldBody)
                            .foregroundColor(MindAlertTheme.mindGreen)
                        }
                        .padding(.top, MindAlertTheme.Spacing._8)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._48)
                }
            }
        }
    }

    @ViewBuilder
    private func textCard(_ text: String) -> some View {
        Text(text)
            .font(.maBoldBody)
            .foregroundColor(MindAlertTheme.textSecondary)
            .fixedSize(horizontal: false, vertical: true)
            .padding(MindAlertTheme.Spacing._16)
            .background(MindAlertTheme.white)
            .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }

    @ViewBuilder
    private func sectionCard(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
            Text(title)
                .font(.maHeadline)
                .foregroundColor(MindAlertTheme.textPrimary)
            Text(body)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }

    @ViewBuilder
    private func componentItem(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
            Text(title)
                .font(.maBoldBody)
                .foregroundColor(MindAlertTheme.textPrimary)
            Text(body)
                .font(.maCaption)
                .foregroundColor(MindAlertTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, MindAlertTheme.Spacing._4)
    }
}

#Preview {
    AboutSafetyPlanView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
