import SwiftUI

struct CopingStrategiesYes: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var newStrategy = ""
    @State private var editingIndex: Int? = nil
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 1)
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image(systemName: "tray.full")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 36, weight: .regular))
                    Text("Coping Strategies")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindBlack)
                }

                Divider()

                Text("Sounds good,\nlet's list your strategies")
                    .foregroundStyle(MindAlertTheme.mindBlack)
                    .font(.system(size: 32, weight: .semibold))

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                            strategyCard(index: index)
                        }

                        // Add Strategies button
                        Button {
                            viewModel.addStrategy("")
                            editingIndex = viewModel.safetyPlan.strategies.count - 1
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add Strategies")
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(MindAlertTheme.mindPeach)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(MindAlertTheme.mindPeach, lineWidth: 1.5)
                            )
                        }
                    }
                }

                Spacer()
                HStack {
                    Spacer()
                    Button("Confirm") { onNext() }
                        .buttonStyle(GreenButton())
                        .opacity(viewModel.safetyPlan.strategies.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.safetyPlan.strategies.isEmpty)
                    Spacer()
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func strategyCard(index: Int) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Strategy \(index + 1)")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.secondary)

            TextField("Enter strategy", text: Binding(
                get: {
                    guard index < viewModel.safetyPlan.strategies.count else { return "" }
                    return viewModel.safetyPlan.strategies[index]
                },
                set: { newValue in
                    guard index < viewModel.safetyPlan.strategies.count else { return }
                    viewModel.safetyPlan.strategies[index] = newValue
                }
            ))
            .font(.system(size: 18, weight: .semibold))

            Rectangle()
                .fill(MindAlertTheme.mindPeach.opacity(0.5))
                .frame(height: 1.5)
        }
        .padding(20)
        .background(MindAlertTheme.cardBackground)
        .cornerRadius(20)
        .contextMenu {
            Button(role: .destructive) {
                viewModel.removeStrategy(at: index)
            } label: {
                Label("Remove", systemImage: "trash")
            }
        }
    }
}
