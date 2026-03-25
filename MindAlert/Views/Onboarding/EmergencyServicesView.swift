import SwiftUI

struct EmergencyServicesView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    @State private var useAlternative = false
    @State private var alternativeService = ""
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                HStack {
                    Spacer()
                    OnboardingProgressIndicator(totalSteps: 3, currentStep: 3)
                    Spacer()
                }

                // Section header
                HStack(spacing: MindAlertTheme.Spacing._12) {
                    Image(systemName: "cross.case")
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .font(.system(size: 32))
                    Text("Emergency Services")
                        .font(.maHeadline)
                        .foregroundStyle(MindAlertTheme.textPrimary)
                }

                Divider()
                    .background(MindAlertTheme.borderSeparator)

                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                    HStack(spacing: 0) {
                        Text("Almost there ")
                        Text(viewModel.safetyPlan.name)
                        Text(",")
                    }
                    Text("let's choose your emergency services")
                }
                .foregroundStyle(MindAlertTheme.textPrimary)
                .font(.maSplashBody)

                // Options card
                VStack(spacing: 0) {
                    // 911 option
                    Button {
                        useAlternative = false
                        viewModel.setEmergencyService("911")
                    } label: {
                        HStack(spacing: MindAlertTheme.Spacing._12) {
                            Image(systemName: !useAlternative ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 24))
                            Text("911")
                                .font(.maSafetyPlanBody)
                                .foregroundStyle(MindAlertTheme.textPrimary)
                            Spacer()
                        }
                        .padding(MindAlertTheme.Spacing._16)
                    }

                    Divider()
                        .background(MindAlertTheme.borderSeparator)
                        .padding(.horizontal, MindAlertTheme.Spacing._16)

                    // 988 option
                    Button {
                        useAlternative = false
                        viewModel.setEmergencyService("988")
                    } label: {
                        HStack(spacing: MindAlertTheme.Spacing._12) {
                            Image(systemName: !useAlternative && viewModel.safetyPlan.emergencyService == "988" ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 24))
                            Text("988 (Suicide & Crisis Lifeline)")
                                .font(.maSafetyPlanBody)
                                .foregroundStyle(MindAlertTheme.textPrimary)
                            Spacer()
                        }
                        .padding(MindAlertTheme.Spacing._16)
                    }

                    Divider()
                        .background(MindAlertTheme.borderSeparator)
                        .padding(.horizontal, MindAlertTheme.Spacing._16)

                    // Alternative option
                    Button {
                        useAlternative = true
                    } label: {
                        VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._8) {
                            HStack(spacing: MindAlertTheme.Spacing._12) {
                                Image(systemName: useAlternative ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(MindAlertTheme.mindGreen)
                                    .font(.system(size: 24))
                                Text("I have an alternative emergency service")
                                    .font(.maSafetyPlanBody)
                                    .foregroundStyle(MindAlertTheme.textPrimary)
                                    .multilineTextAlignment(.leading)
                            }

                            if useAlternative {
                                TextField("Enter service number", text: $alternativeService)
                                    .font(.maHeadline)
                                    .keyboardType(.phonePad)
                                    .padding(.leading, 36)
                                    .foregroundStyle(MindAlertTheme.textPrimary)
                                    .onChange(of: alternativeService) { _, newValue in
                                        if !newValue.isEmpty {
                                            viewModel.setEmergencyService(newValue)
                                        }
                                    }
                            }
                        }
                        .padding(MindAlertTheme.Spacing._16)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: MindAlertTheme.Radius._24)
                        .fill(MindAlertTheme.cardBackground)
                )

                Spacer()

                HStack {
                    Spacer()
                    Button("Confirm") { onNext() }
                        .buttonStyle(GreenButton())
                    Spacer()
                }
                .padding(.bottom, MindAlertTheme.Spacing._8)
            }
            .padding(MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
