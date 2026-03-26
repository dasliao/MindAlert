import SwiftUI

@main
struct MindAlertApp: App {
    @StateObject private var router = AppRouter()
    @StateObject private var viewModel = SafetyPlanViewModel()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(router)
                .environmentObject(viewModel)
        }
    }
}
