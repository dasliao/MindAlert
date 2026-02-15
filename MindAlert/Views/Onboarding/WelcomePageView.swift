import SwiftUI

enum WelcomePage {
    case hello(name: String)
    case safetyPlanOverview
    case panicButton

    struct FeatureItem {
        let icon: String
        let text: String
    }
}

struct WelcomePageView: View {
    let page: WelcomePage
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                headerSection
                VStack(alignment: .center) {
                    contentCard
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    @ViewBuilder
    private var headerSection: some View {
        switch page {
        case .hello(let name):
            VStack(alignment: .leading) {
                Text("Hello")
                    .font(.system(size: 40, weight: .bold))
                HStack(spacing: 0) {
                    Text(name)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                    Text("!")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                }
            }
            .padding(.horizontal)
        default:
            Spacer(minLength: 50)
        }
    }

    @ViewBuilder
    private var contentCard: some View {
        switch page {
        case .hello:
            helloCard
        case .safetyPlanOverview:
            safetyPlanCard
        case .panicButton:
            panicButtonCard
        }
    }

    private var helloCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            Text("\(Text("Mind").foregroundColor(MindAlertTheme.mindGreen)) \(Text("Alert").foregroundColor(MindAlertTheme.mindPeach)) helps you prepare a Safety Plan for suicidal crisis so you can stay safe. ")
                .font(.system(size: 32, weight: .semibold))
            Spacer()
            nextButton
        }
        .mindAlertCard()
    }

    private var safetyPlanCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your \(Text("Safety Plan").foregroundStyle(MindAlertTheme.mindGreen)) will include")
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(MindAlertTheme.mindBlack)
            Spacer()
            VStack(alignment: .leading, spacing: 40) {
                featureRow(icon: "tray.full", text: "Coping strategies")
                featureRow(icon: "person.2.wave.2", text: "Alerting your emergency contact(s)")
                featureRow(icon: "cross.case", text: "Alerting medical emergency services")
            }
            Spacer()
            nextButton
        }
        .mindAlertCard()
    }

    private var panicButtonCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView {
                Spacer(minLength: 30)
                VStack(alignment: .leading, spacing: 10) {
                    Text("After creating your \(Text("Safety Plan").foregroundStyle(MindAlertTheme.mindGreen)), a panic button will become available.")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(MindAlertTheme.mindBlack)
                    Spacer(minLength: 30)
                    HStack {
                        Spacer()
                        Image("TheButton")
                        Spacer()
                    }
                    Spacer(minLength: 30)
                    Text("Press and hold this button for 3 seconds during a suicidal crisis to activate all features of the \(Text("Safety Plan").foregroundStyle(MindAlertTheme.mindGreen)) immediately.  ")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(MindAlertTheme.mindBlack)
                    Spacer(minLength: 30)
                }
            }
            nextButton
        }
        .mindAlertCard()
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .foregroundStyle(MindAlertTheme.mindGreen)
                .frame(width: 70)
                .font(.system(size: 36, weight: .regular))
            Text(text)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(MindAlertTheme.mindBlack)
        }
    }

    private var nextButton: some View {
        HStack {
            Spacer()
            Button("Next") { onNext() }
                .buttonStyle(GreenButton())
            Spacer()
        }
    }
}
