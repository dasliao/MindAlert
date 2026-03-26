import SwiftUI

// MARK: - Navigation Destination

enum AppScreen: Equatable {
    // Onboarding
    case splash
    case initial
    case name
    case infoDisclaimer
    case aboutSafetyPlan
    case peopleThatHelp
    case professionalSupport
    case copingStrategiesIntro
    case copingStrategiesInput
    case emergencyServices
    case setupConfirmation
    // Main App
    case home
}

// MARK: - AppRouter

@MainActor
final class AppRouter: ObservableObject {
    @Published var screen: AppScreen

    init() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "onboardingComplete")
        self.screen = hasCompletedOnboarding ? .home : .splash
    }

    func navigate(to screen: AppScreen) {
        withAnimation(.easeInOut(duration: 0.3)) {
            self.screen = screen
        }
    }

    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "onboardingComplete")
        navigate(to: .home)
    }

    func resetOnboarding() {
        UserDefaults.standard.removeObject(forKey: "onboardingComplete")
        navigate(to: .splash)
    }
}
