import SwiftUI

struct HomeTabView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onRerunOnboarding: () -> Void
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Resources", systemImage: "tray.2", value: 0) {
                ResourcesView()
            }
            Tab("Safety Plan", systemImage: "house.fill", value: 1) {
                HomeView(viewModel: viewModel)
            }
            Tab("Profile", systemImage: "person", value: 2) {
                ProfileView(viewModel: viewModel, onRerunOnboarding: onRerunOnboarding)
            }
        }
        .tint(MindAlertTheme.mindGreen)
    }
}
