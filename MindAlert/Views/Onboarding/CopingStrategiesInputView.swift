import SwiftUI

/// Matches Play page: CopingStrategiesInput
/// Text: "Let's take some time to thinking about some coping strategies."
struct CopingStrategiesInputView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var viewModel: SafetyPlanViewModel

    @State private var strategies: [String] = ["", "", ""]
    @FocusState private var focusedIndex: Int?

    private var canContinue: Bool {
        strategies.contains { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    var body: some View {
        ZStack {
            MindAlertTheme.lightGray.ignoresSafeArea()

            VStack(spacing: 0) {
                MANavigation(title: "Coping Strategies", onBack: { router.navigate(to: .copingStrategiesIntro) })
                    .padding(.top, MindAlertTheme.Spacing._8)

                ScrollView {
                    VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._16) {
                        Text("Let's take some time to thinking about some coping strategies.")
                            .font(.maLargeTitle)
                            .foregroundColor(MindAlertTheme.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)

                        VStack(spacing: MindAlertTheme.Spacing._8) {
                            ForEach(strategies.indices, id: \.self) { idx in
                                StrategyInputBox(
                                    number: idx + 1,
                                    text: $strategies[idx],
                                    isFocused: focusedIndex == idx
                                )
                                .focused($focusedIndex, equals: idx)
                                .onSubmit {
                                    if idx == strategies.count - 1 {
                                        strategies.append("")
                                        focusedIndex = idx + 1
                                    } else {
                                        focusedIndex = idx + 1
                                    }
                                }
                            }

                            // Add button
                            Button {
                                strategies.append("")
                                focusedIndex = strategies.count - 1
                            } label: {
                                HStack(spacing: MindAlertTheme.Spacing._8) {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add")
                                }
                                .font(.maBoldBody)
                                .foregroundColor(MindAlertTheme.mindGreen)
                                .frame(maxWidth: .infinity)
                                .padding(MindAlertTheme.Spacing._16)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, MindAlertTheme.Spacing._24)
                    .padding(.top, MindAlertTheme.Spacing._16)
                    .padding(.bottom, MindAlertTheme.Spacing._32)
                }

                MAProgressButtons(
                    variant: .single,
                    primaryTitle: "Save & Continue",
                    primaryEnabled: canContinue,
                    onPrimary: {
                        let filtered = strategies.map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
                        viewModel.safetyPlan.strategies = filtered
                        viewModel.save()
                        router.navigate(to: .peopleThatHelp)
                    }
                )
            }
        }
        .onAppear {
            if !viewModel.safetyPlan.strategies.isEmpty {
                strategies = viewModel.safetyPlan.strategies + [""]
            }
        }
    }
}

#Preview {
    CopingStrategiesInputView()
        .environmentObject(AppRouter())
        .environmentObject(SafetyPlanViewModel())
}
