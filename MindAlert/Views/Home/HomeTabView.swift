import SwiftUI

struct HomeTabView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Resources", systemImage: "tray.2", value: 0) {
                ResourcesView()
            }
            Tab("Home", systemImage: "house.fill", value: 1) {
                HomeView(viewModel: viewModel)
            }
            Tab("Profile", systemImage: "person", value: 2) {
                ProfileView(viewModel: viewModel)
            }
        }
        .tint(MindAlertTheme.mindGreen)
    }
}
