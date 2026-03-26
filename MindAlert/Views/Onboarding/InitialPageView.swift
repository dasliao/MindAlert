import SwiftUI

/// Onboarding step 2 of 11.
/// Matches Play page: InitialPage — just the brand colored title, full screen.
struct InitialPageView: View {
    @EnvironmentObject var router: AppRouter
    @State private var appeared = false

    var body: some View {
        ZStack {
            MindAlertTheme.whiteGreen.ignoresSafeArea()

            VStack {
                Spacer()

                MindAlertTitle(font: .maSafetyPlanTitle)
                    .opacity(appeared ? 1 : 0)
                    .scaleEffect(appeared ? 1 : 0.85)

                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appeared = true
            }
            // Auto-advance after 1.5s
            Task {
                try? await Task.sleep(for: .seconds(1.5))
                router.navigate(to: .name)
            }
        }
        .onTapGesture {
            router.navigate(to: .name)
        }
    }
}

#Preview {
    InitialPageView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
