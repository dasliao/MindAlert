import SwiftUI

struct InfoAndDisclaimer: View {
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 4, currentStep: 0)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 15) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 36, weight: .regular))
                            Text("Info and Disclaimer")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                        }
                        Spacer()
                        ScrollView {
                            Spacer(minLength: 40)
                            VStack(alignment: .leading, spacing: 50) {
                                disclaimerRow(number: "1.circle",
                                    text: "You can complete this plan entirely on your own, with someone you trust, or your doctor / mental health provider.")
                                disclaimerRow(number: "2.circle",
                                    text: "This app can't replace professional treatment. You are deserving of help. This app includes a list of further resources you can view after setup.")
                                disclaimerRow(number: "3.circle",
                                    text: "Trigger Warning: Suicidal crisis is mentioned throughout the setup process. Please proceed with caution or with supervision from a professional.")
                            }
                            Spacer(minLength: 40)
                        }

                        HStack {
                            Spacer()
                            Button("Next") { onNext() }
                                .buttonStyle(GreenButton())
                            Spacer()
                        }
                    }
                    .mindAlertCard()

                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.all)
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func disclaimerRow(number: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: number)
                .foregroundStyle(MindAlertTheme.mindPeach)
                .font(.system(size: 32, weight: .regular))
            Text(text)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(MindAlertTheme.mindBlack)
        }
    }
}
