import SwiftUI

/// Main app tab container. Matches Play component: Tab_1 (3 tabs).
/// Tabs: Resources (ProfessionalSupport) | Home | Profile (ProfileSetting)
struct HomeTabView: View {
    @EnvironmentObject var viewModel: SafetyPlanViewModel
    @EnvironmentObject var router: AppRouter
    @State private var selectedTab: HomeTab = .home

    var body: some View {
        VStack(spacing: 0) {
            // Active screen
            Group {
                switch selectedTab {
                case .resources:
                    ProfessionalSupportView(isOnboarding: false)
                case .home:
                    HomeView()
                case .profile:
                    ProfileSettingView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom tab bar
            MATabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    HomeTabView()
        .environmentObject({
            let vm = SafetyPlanViewModel()
            vm.setName("Alex")
            return vm
        }())
        .environmentObject(AppRouter())
}
