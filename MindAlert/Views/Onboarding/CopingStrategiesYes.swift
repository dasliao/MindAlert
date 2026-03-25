import SwiftUI

struct CopingStrategiesYes: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var newStrategy = ""
    @State private var editingIndex: Int? = nil
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 1)
                    Spacer()
                }

                // Section header
                HStack(spacing: MindAlertTheme.Spacing._12) {
                    Image(systemName: "tray.full")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 32))
                    Text("Coping Strategies")
                        .font(.maHeadline)
                        .foregroundStyle(MindAlertTheme.textPrimary)
                }

                Divider()
                    .background(MindAlertTheme.borderSeparator)

                Text("Sounds good,\nlet's list your strategies.")
                    .foregroundStyle(MindAlertTheme.textPrimary)
                    .font(.maSplashBody)

                ScrollView {
                    VStack(spacing: MindAlertTheme.Spacing._16) {
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
                            .font(.maBoldBody)
                            .foregroundStyle(MindAlertTheme.mindPeach)
                            .padding(.vertical, MindAlertTheme.Spacing._12)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24)
                                    .stroke(MindAlertTheme.mindPeach, lineWidth: 1.5)
                            )
                        }
                    }
                }

                Spacer()

                HStack {
                    Spacer()
                    Button("Confirm") { onNext() }
                        .buttonStyle(GreenButton(disabled: viewModel.safetyPlan.strategies.isEmpty))
                        .disabled(viewModel.safetyPlan.strategies.isEmpty)
                    Spacer()
                }
                .padding(.bottom, MindAlertTheme.Spacing._8)
            }
            .padding(MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func strategyCard(index: Int) -> some View {
        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
            Text("Strategy \(index + 1)")
                .font(.maCaption)
                .foregroundStyle(MindAlertTheme.textTertiary)

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
            .font(.maHeadline)
            .foregroundStyle(MindAlertTheme.textPrimary)

            Rectangle()
                .fill(MindAlertTheme.mindPeach.opacity(0.5))
                .frame(height: 1.5)
        }
        .mindAlertCard()
        .contextMenu {
            Button(role: .destructive) {
                viewModel.removeStrategy(at: index)
            } label: {
                Label("Remove", systemImage: "trash")
            }
        }
    }
}
