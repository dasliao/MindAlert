import SwiftUI

struct WelcomePageView: View {
    let name: String
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                // Header greeting
                HStack(spacing: 0) {
                    Text("Hello, ")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.textPrimary)
                    Text("\(name)!")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                        // Description
                        (Text("Mind")
                            .foregroundColor(MindAlertTheme.mindGreen)
                        + Text("Alert")
                            .foregroundColor(MindAlertTheme.mindPeach)
                        + Text(" helps you prepare a ")
                            .foregroundColor(MindAlertTheme.textPrimary)
                        + Text("Safety Plan")
                            .foregroundColor(MindAlertTheme.mindGreen)
                        + Text(" for suicidal crisis so you can stay safe.")
                            .foregroundColor(MindAlertTheme.textPrimary))
                        .font(.maSplashBody)

                        // Safety Plan features card
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                            Text("Your Safety Plan\nwill include:")
                                .font(.maPageHeaderSmall)
                                .foregroundStyle(MindAlertTheme.textPrimary)

                            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._24) {
                                featureRow(icon: "tray.full", text: "Links to your coping strategies")
                                featureRow(icon: "person.2.wave.2", text: "Alerting your emergency contact(s)")
                                featureRow(icon: "cross.case", text: "Alerting medical emergency services")
                            }
                        }
                        .mindAlertCard()

                        // Panic button info
                        (Text("After creating your ")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        + Text("Safety Plan")
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        + Text(", a ")
                            .foregroundStyle(MindAlertTheme.textPrimary)
                        + Text("Panic Button")
                            .foregroundStyle(MindAlertTheme.mindPeach)
                        + Text(" will become available.")
                            .foregroundStyle(MindAlertTheme.textPrimary))
                        .font(.maSplashBody)
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                }

                HStack {
                    Spacer()
                    Button("Next") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom, MindAlertTheme.Spacing._16)
            }
            .padding(.vertical, MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: MindAlertTheme.Spacing._16) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .font(.system(size: 24))
                .frame(width: 32)
            Text(text)
                .font(.maBoldBody)
                .foregroundStyle(MindAlertTheme.textPrimary)
        }
    }
}
