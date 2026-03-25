import SwiftUI

struct CompleteView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 3)
                    Spacer()
                }

                Divider()
                    .background(MindAlertTheme.borderSeparator)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        // Checkmark + congratulations
                        HStack {
                            Spacer()
                            VStack(spacing: MindAlertTheme.Spacing._12) {
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 48, weight: .light))
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                                Text("You did it,\n\(viewModel.safetyPlan.name)!")
                                    .font(.maLargeTitle)
                                    .foregroundStyle(MindAlertTheme.textPrimary)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                        }

                        // Panic Button explanation card
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                            (Text("A ")
                                .foregroundStyle(MindAlertTheme.textPrimary)
                            + Text("Panic Button")
                                .foregroundStyle(MindAlertTheme.mindPeach)
                            + Text(" is now available for you.")
                                .foregroundStyle(MindAlertTheme.textPrimary))
                            .font(.maPageHeaderSmall)

                            // Nested card with button preview
                            VStack(spacing: MindAlertTheme.Spacing._12) {
                                Text("It looks like this.")
                                    .font(.maCaption)
                                    .foregroundStyle(MindAlertTheme.textSecondary)

                                ZStack {
                                    Circle()
                                        .fill(MindAlertTheme.mindGreen)
                                        .frame(width: 80, height: 80)
                                    Image("Logo_White")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }

                                Text("To activate your Safety Plan,\n**press and hold this button for 3 seconds** during a suicidal crisis.")
                                    .font(.maCaption)
                                    .foregroundStyle(MindAlertTheme.textPrimary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(MindAlertTheme.Spacing._24)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24)
                                    .fill(MindAlertTheme.lightGray)
                            )
                        }
                        .mindAlertCard()

                        // Post-activation info
                        (Text("After the plan is activated, we will ")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        + Text("message your emergency contacts")
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        + Text(" and ")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        + Text("notify your emergency services")
                            .foregroundStyle(MindAlertTheme.mindPeach)
                        + Text(".")
                            .foregroundStyle(MindAlertTheme.textPrimary))
                        .font(.maSplashBody)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._4)
                }

                HStack {
                    Spacer()
                    Button("Done") {
                        viewModel.save()
                        onFinish()
                    }
                    .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom, MindAlertTheme.Spacing._8)
            }
            .padding(MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
