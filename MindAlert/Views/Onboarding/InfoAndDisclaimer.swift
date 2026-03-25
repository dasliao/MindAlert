import SwiftUI

struct InfoAndDisclaimer: View {
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                // Header
                HStack(spacing: MindAlertTheme.Spacing._12) {
                    Image(systemName: "square.fill.text.grid.1x2")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 32))
                    Text("Info and Disclaimer")
                        .font(.maHeadline)
                        .foregroundStyle(MindAlertTheme.textPrimary)
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)

                ScrollView {
                    VStack(spacing: MindAlertTheme.Spacing._16) {
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
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                }

                Spacer()

                HStack {
                    Spacer()
                    Button("I understand") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom, MindAlertTheme.Spacing._16)
            }
            .padding(.vertical, MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func disclaimerCard(number: Int, text: LocalizedStringKey) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
            Text("\(number)")
                .font(.system(size: 36, weight: .light))
                .foregroundStyle(MindAlertTheme.mindLightGreen)
            Text(text)
                .font(.maBoldBody)
                .foregroundStyle(MindAlertTheme.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mindAlertCard()
    }
}
