import SwiftUI

struct InfoAndDisclaimer: View {
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: "square.fill.text.grid.1x2")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 36, weight: .regular))
                    Text("Info and Disclaimer")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindBlack)
                }
                .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 16) {
                        disclaimerCard(
                            number: 1,
                            text: "You can complete this plan entirely on your own, with someone you trust, or your doctor/mental health provider."
                        )
                        disclaimerCard(
                            number: 2,
                            text: "This app is **not** a replacement for professional treatment. **You are deserving of help**.\nWe included a list of further resources you can view after setup."
                        )
                        disclaimerCard(
                            number: 3,
                            text: "**Trigger Warning:** Suicidal crisis is mentioned throughout the setup process. Please proceed with caution or with supervision from a professional."
                        )
                    }
                    .padding(.horizontal)
                }

                Spacer()

                HStack {
                    Spacer()
                    Button("I understand") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom)
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func disclaimerCard(number: Int, text: LocalizedStringKey) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(number)")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(MindAlertTheme.mindLightGreen)
            Text(text)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(MindAlertTheme.mindBlack)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(MindAlertTheme.cardBackground)
        .cornerRadius(20)
    }
}
