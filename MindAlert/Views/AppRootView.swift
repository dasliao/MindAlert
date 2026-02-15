import SwiftUI

enum AppFlow {
    case loading
    case onboarding
    case home
}

struct AppRootView: View {
    @StateObject private var viewModel = SafetyPlanViewModel()
    @State private var appFlow: AppFlow = .loading

    var body: some View {
        Group {
            switch appFlow {
            case .loading:
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                if viewModel.hasSavedPlan {
                                    appFlow = .home
                                } else {
                                    appFlow = .onboarding
                                }
                            }
                        }
                    }
            case .onboarding:
                OnboardingFlowView(viewModel: viewModel) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        appFlow = .home
                    }
                }
            case .home:
                HomeTabView(viewModel: viewModel)
            }
        }
    }
}
