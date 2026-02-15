import SwiftUI

struct CopingStrategiesYes: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var newStrategy = ""
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 4, currentStep: 1)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 15) {
                            Image(systemName: "tray.full")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 36, weight: .regular))
                            Text("Coping Strategies")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                        }
                        Spacer()

                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Sounds good, \nlet's list your strategies ")
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                    .font(.system(size: 32, weight: .semibold))

                                ForEach(viewModel.safetyPlan.strategies.indices, id: \.self) { index in
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack {
                                            Text("Strategy \(index + 1)")
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(MindAlertTheme.mindPeach, lineWidth: 3)
                                                )
                                                .font(.system(size: 16, weight: .medium))

                                            Spacer()

                                            Button {
                                                viewModel.removeStrategy(at: index)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundStyle(MindAlertTheme.mindPeach)
                                            }
                                        }

                                        Text(viewModel.safetyPlan.strategies[index])
                                            .font(.system(size: 20, weight: .semibold))
                                            .padding(.bottom, 10)
                                    }
                                    .padding(.top, 10)
                                }

                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Add New Strategy")
                                        .padding(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(MindAlertTheme.mindPeach, lineWidth: 3)
                                        )
                                        .font(.system(size: 16, weight: .medium))

                                    HStack {
                                        TextField("Ex: Play Minecraft", text: $newStrategy)
                                            .font(.system(size: 20, weight: .semibold))
                                            .underlineTextField()

                                        Button {
                                            if !newStrategy.isEmpty {
                                                viewModel.addStrategy(newStrategy)
                                                newStrategy = ""
                                            }
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundStyle(MindAlertTheme.mindGreen)
                                                .font(.system(size: 24))
                                        }
                                    }
                                }
                                .padding(.top, 20)
                            }
                        }

                        Spacer()
                        HStack {
                            Spacer()
                            Button("Next") { onNext() }
                                .buttonStyle(GreenButton())
                            Spacer()
                        }
                    }
                    .mindAlertCard()
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
