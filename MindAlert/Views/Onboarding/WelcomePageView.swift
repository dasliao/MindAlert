import SwiftUI

struct WelcomePageView: View {
    let name: String
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                // Header
                HStack(spacing: 0) {
                    Text("Hello, ")
                        .font(.system(size: 40, weight: .bold))
                    Text("\(name)!")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                }
                .padding(.horizontal)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Description
                        Text("\(Text("Mind").foregroundColor(MindAlertTheme.mindGreen))\(Text("Alert").foregroundColor(MindAlertTheme.mindPeach)) helps you prepare a \(Text("Safety Plan").foregroundColor(MindAlertTheme.mindGreen)) for suicidal crisis so you can stay safe.")
                            .font(.system(size: 28, weight: .semibold))

                        // Safety Plan card
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Your Safety Plan\nwill include:")
                                .font(.system(size: 24, weight: .semibold))

                            VStack(alignment: .leading, spacing: 24) {
                                featureRow(icon: "tray.full", text: "Links to your coping strategies")
                                featureRow(icon: "person.2.wave.2", text: "Alerting your emergency contact(s)")
                                featureRow(icon: "cross.case", text: "Alerting medical emergency services")
                            }
                        }
                        .padding(25)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(MindAlertTheme.cardBackground)
                        )

                        // Panic button info
                        Text("After creating your \(Text("Safety Plan").foregroundStyle(MindAlertTheme.mindGreen)), a \(Text("Panic Button").foregroundStyle(MindAlertTheme.mindPeach)) will become available.")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(MindAlertTheme.mindBlack)
                    }
                    .padding(.horizontal)
                }

                HStack {
                    Spacer()
                    Button("Next") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom)
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .font(.system(size: 28, weight: .regular))
                .frame(width: 40)
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(MindAlertTheme.mindBlack)
        }
    }
}
