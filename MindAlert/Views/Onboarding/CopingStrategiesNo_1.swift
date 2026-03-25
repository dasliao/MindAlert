import SwiftUI

struct CopingStrategiesNo_1: View {
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 1)
                    Spacer()
                }

                Spacer(minLength: MindAlertTheme.Spacing._12)

                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                    // Section header
                    HStack(spacing: MindAlertTheme.Spacing._12) {
                        Image(systemName: "tray.full")
                            .foregroundStyle(MindAlertTheme.mindGreen)
                            .font(.system(size: 32))
                        Text("Coping Strategies")
                            .font(.maHeadline)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                    }

                    Spacer()

                    ScrollView {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                            Text("Okay, no worries!\nCoping strategies are activities that help distract you until help arrives.")
                                .font(.maSplashBody)
                                .foregroundStyle(MindAlertTheme.textPrimary)

                            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                                Text("For Example")
                                    .font(.maPageHeaderSmall)
                                    .foregroundStyle(MindAlertTheme.textPrimary)

                                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._32) {
                                    exampleRow(icon: "play.tv",
                                        text: "Paste the links of your favorite video, playlist or website.")
                                    exampleRow(icon: "books.vertical",
                                        text: "List your favorite hobbies: video games, reading, painting, etc.")
                                    exampleRow(icon: "pawprint",
                                        text: "You can also do chores, play with a pet, wash your face, and more!")
                                }
                            }
                        }
                    }

                    HStack {
                        Spacer()
                        Button("Understood") { onNext() }
                            .buttonStyle(GreenButton())
                        Spacer()
                    }
                }
                .mindAlertCard()
            }
            .padding(MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func exampleRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: MindAlertTheme.Spacing._16) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .frame(width: 32)
                .font(.system(size: 28))
            Text(text)
                .font(.maSafetyPlanBody)
                .foregroundStyle(MindAlertTheme.textPrimary)
        }
    }
}
