import SwiftUI

struct PanicButton: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var isPressed = false
    @State private var showingActivatedPlan = false
    @State private var holdTimer: Timer?
    @State private var countdownTimer: Timer?
    @State private var countdown: Int? = nil
    @State private var circleScale: CGFloat = 1.0

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
                if let countdown = countdown {
                    Text("\(countdown)")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundStyle(.white)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    // Logo icon
                    VStack(spacing: 0) {
                        Image("Logo_White")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
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
                SafetyPlanActivatedView(viewModel: viewModel)
            }
        }
    }

    private func startCountdown(maxScale: CGFloat) {
        countdown = 3

        // Animate circle expansion over 3 seconds
        withAnimation(.linear(duration: holdDuration)) {
            circleScale = maxScale
        }

        // Countdown ticks: 3 -> 2 -> 1
        var tick = 0
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor in
                tick += 1
                if tick >= 3 {
                    countdownTimer?.invalidate()
                    countdownTimer = nil
                    // Activated
                    withAnimation(.easeOut(duration: 0.2)) {
                        countdown = nil
                    }
                    showingActivatedPlan = true
                    // Reset after showing
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isPressed = false
                        circleScale = 1.0
                        countdown = nil
                    }
                } else {
                    withAnimation(.spring(duration: 0.3)) {
                        countdown = 3 - tick
                    }
                }
            }
        }
    }

    private func cancelCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        holdTimer?.invalidate()
        holdTimer = nil
        withAnimation(.easeOut(duration: 0.3)) {
            circleScale = 1.0
            countdown = nil
        }
        isPressed = false
    }
}
