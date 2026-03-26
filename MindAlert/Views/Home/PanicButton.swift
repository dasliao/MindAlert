import SwiftUI

struct PanicButton: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @EnvironmentObject var router: AppRouter

    @State private var isPressed = false
    @State private var showingActivatedPlan = false
    @State private var countdown: Int? = nil
    @State private var circleScale: CGFloat = 1.0
    @State private var countdownTask: Task<Void, Never>?

    let holdDuration: TimeInterval = 3.0
    let idleSize: CGFloat = 220

    var body: some View {
        GeometryReader { geo in
            let maxScale = max(geo.size.width, geo.size.height) * 2 / idleSize

            ZStack {
                // Expanding green circle
                Circle()
                    .fill(MindAlertTheme.mindGreen)
                    .frame(width: idleSize, height: idleSize)
                    .scaleEffect(circleScale)

                // Content: logo or countdown number
                if let countdown {
                    Text("\(countdown)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundColor(MindAlertTheme.staticWhite)
                        .transition(.scale.combined(with: .opacity))
                        .id(countdown)
                } else {
                    Image("Logo_White")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        guard !isPressed else { return }
                        isPressed = true
                        startCountdown(maxScale: maxScale)
                    }
                    .onEnded { _ in
                        if !showingActivatedPlan {
                            cancelCountdown()
                        }
                    }
            )
            .fullScreenCover(isPresented: $showingActivatedPlan) {
                PlanActivatedView()
                    .environmentObject(router)
                    .environmentObject(viewModel)
            }
        }
    }

    private func startCountdown(maxScale: CGFloat) {
        countdown = 3
        HapticManager.shared.playGradientHaptic()

        withAnimation(.linear(duration: holdDuration)) {
            circleScale = maxScale
        }

        countdownTask = Task { @MainActor in
            for tick in 1...3 {
                try? await Task.sleep(for: .seconds(1))
                guard !Task.isCancelled else { return }

                if tick >= 3 {
                    withAnimation(.easeOut(duration: 0.2)) {
                        countdown = nil
                    }
                    showingActivatedPlan = true
                    try? await Task.sleep(for: .milliseconds(500))
                    isPressed = false
                    circleScale = 1.0
                } else {
                    withAnimation(.spring(duration: 0.3)) {
                        countdown = 3 - tick
                    }
                }
            }
        }
    }

    private func cancelCountdown() {
        countdownTask?.cancel()
        countdownTask = nil
        HapticManager.shared.stopHaptic()
        withAnimation(.easeOut(duration: 0.3)) {
            circleScale = 1.0
            countdown = nil
        }
        isPressed = false
    }
}
