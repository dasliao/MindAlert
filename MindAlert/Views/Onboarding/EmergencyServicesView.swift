import SwiftUI

struct EmergencyServicesView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var useAlternative = false
    @State private var alternativeService = ""
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 3)
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image(systemName: "cross.case")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 36, weight: .regular))
                    Text("Emergency Services")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(MindAlertTheme.mindBlack)
                }

                Divider()

                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Almost there ")
                        Text(viewModel.safetyPlan.name)
                        Text(",")
                    }
                    Text("let's choose your emergency services")
                }
                .foregroundStyle(MindAlertTheme.mindBlack)
                .font(.system(size: 32, weight: .semibold))

                // Options card
                VStack(spacing: 0) {
                    // 911 option
                    Button {
                        useAlternative = false
                        viewModel.setEmergencyService("911")
                    } label: {
                        HStack {
                            Image(systemName: !useAlternative ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 24))
                            Text("911")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                            Spacer()
                        }
                        .padding()
                    }

                    Divider()
                        .padding(.horizontal)

                    // Alternative option
                    Button {
                        useAlternative = true
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: useAlternative ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                                    .font(.system(size: 24))
                                Text("I have an alternative emergency service")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                    .multilineTextAlignment(.leading)
                            }

                            if useAlternative {
                                TextField("Enter service number", text: $alternativeService)
                                    .font(.system(size: 18))
                                    .keyboardType(.phonePad)
                                    .padding(.leading, 40)
                                    .foregroundStyle(MindAlertTheme.mindBlack)
                                    .onChange(of: alternativeService) { _, newValue in
                                        if !newValue.isEmpty {
                                            viewModel.setEmergencyService(newValue)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
                .background(MindAlertTheme.cardBackground)
                .cornerRadius(20)

                Spacer()
                HStack {
                    Spacer()
                    Button("Confirm") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
