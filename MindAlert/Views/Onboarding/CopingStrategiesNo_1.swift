import SwiftUI

struct CopingStrategiesNo_1: View {
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 4, currentStep: 1)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 15) {
                            Image(systemName: "tray.full")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 36, weight: .regular))
                            Text("Coping Strategies")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                        }
                        Spacer()
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Okay, no worries!\nCoping strategies are activities that help distract you until help arrives.")
                                Spacer(minLength: 60)
                                VStack(alignment: .leading) {
                                    Text("For Example")
                                    Spacer(minLength: 30)
                                    VStack(alignment: .leading, spacing: 50) {
                                        exampleRow(icon: "play.tv",
                                            text: "Paste the links of your favorite video, playlist or website.")
                                        exampleRow(icon: "books.vertical",
                                            text: "List your favorite hobbies: video games, reading, painting, etc.")
                                        exampleRow(icon: "pawprint",
                                            text: "You can also do chores, play with a pet, wash your face, and more!")
                                    }
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                }
                                Spacer()
                            }
                            .foregroundStyle(MindAlertTheme.mindBlack)
                            .font(.system(size: 32, weight: .semibold))
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
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func exampleRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .frame(width: 40)
                .font(.system(size: 32, weight: .regular))
            Text(text)
        }
    }
}
