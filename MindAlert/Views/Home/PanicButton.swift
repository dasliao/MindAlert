import SwiftUI

struct PanicButton: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var progress: CGFloat = 0
    @State private var isPressed = false
    @State private var showingActivatedPlan = false
    @State private var holdTimer: Timer?

    let holdDuration: TimeInterval = 3.0

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Background glow when pressing
                Circle()
                    .fill(MindAlertTheme.mindPeach.opacity(isPressed ? 0.3 : 0))
                    .frame(width: 220, height: 220)
                    .animation(.easeOut, value: isPressed)

                // Progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        MindAlertTheme.mindGreen,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 190, height: 190)

                Image("TheButtonLarge")
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        guard !isPressed else { return }
                        isPressed = true
                        withAnimation(.linear(duration: holdDuration)) {
                            progress = 1.0
                        }
                        holdTimer = Timer.scheduledTimer(withTimeInterval: holdDuration, repeats: false) { _ in
                            Task { @MainActor in
                                showingActivatedPlan = true
                                isPressed = false
                                progress = 0
                            }
                        }
                    }
                    .onEnded { _ in
                        if !showingActivatedPlan {
                            holdTimer?.invalidate()
                            holdTimer = nil
                            withAnimation(.easeOut(duration: 0.3)) {
                                progress = 0
                            }
                            isPressed = false
                        }
                    }
            )

            (Text("Press the Button for 3 Seconds\nto activate your ")
                .font(.system(size: 20))
                .foregroundStyle(MindAlertTheme.mindGreen)
            + Text("Safety Plan")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(MindAlertTheme.mindGreen)
            + Text(".")
                .font(.system(size: 20))
                .foregroundStyle(MindAlertTheme.mindGreen))
            .multilineTextAlignment(.center)
        }
        .fullScreenCover(isPresented: $showingActivatedPlan) {
            SafetyPlanActivatedView(viewModel: viewModel)
        }
    }
}
