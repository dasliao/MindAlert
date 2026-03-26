import SwiftUI

struct AppRootView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    var body: some View {
        Group {
            switch router.screen {
            // MARK: Onboarding
            case .splash:
                SplashScreenView()
            case .initial:
                InitialPageView()
            case .name:
                NameView()
            case .infoDisclaimer:
                InfoDisclaimerView()
            case .aboutSafetyPlan:
                AboutSafetyPlanView()
            case .peopleThatHelp:
                PeopleThatHelpView()
            case .professionalSupport:
                ProfessionalSupportView()
            case .copingStrategiesIntro:
                CopingStrategiesIntroView()
            case .copingStrategiesInput:
                CopingStrategiesInputView()
            case .emergencyServices:
                EmergencyServicesView()
            case .setupConfirmation:
                SetupConfirmationView()
            // MARK: Main App
            case .home:
                HomeTabView()
            }
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.3), value: router.screen)
    }
}
