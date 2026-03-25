import SwiftUI

enum OnboardingStep: Hashable {
    case welcome
    case infoDisclaimer
    case copingBranch
    case copingNo
    case copingYes
    case emergencyContacts
    case emergencyServices
    case complete
}

struct OnboardingFlowView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var path = NavigationPath()
    var onComplete: () -> Void

    var body: some View {
        NavigationStack(path: $path) {
            NameView(viewModel: viewModel) {
                path.append(OnboardingStep.welcome)
            }
            .navigationDestination(for: OnboardingStep.self) { step in
                switch step {
                case .welcome:
                    WelcomePageView(name: viewModel.safetyPlan.name) {
                        path.append(OnboardingStep.infoDisclaimer)
                    }
                case .infoDisclaimer:
                    InfoAndDisclaimer {
                        path.append(OnboardingStep.copingBranch)
                    }
                case .copingBranch:
                    CopingStrategies(
                        viewModel: viewModel,
                        onYes: { path.append(OnboardingStep.copingYes) },
                        onNo: { path.append(OnboardingStep.copingNo) }
                    )
                case .copingNo:
                    CopingStrategiesNo_1 {
                        path.append(OnboardingStep.copingYes)
                    }
                case .copingYes:
                    CopingStrategiesYes(viewModel: viewModel) {
                        path.append(OnboardingStep.emergencyContacts)
                    }
                case .emergencyContacts:
                    EmergencyContacts(viewModel: viewModel) {
                        path.append(OnboardingStep.emergencyServices)
                    }
                case .emergencyServices:
                    EmergencyServicesView(viewModel: viewModel) {
                        path.append(OnboardingStep.complete)
                    }
                case .complete:
                    CompleteView(viewModel: viewModel, onFinish: onComplete)
                }
            }
        }
    }
}
