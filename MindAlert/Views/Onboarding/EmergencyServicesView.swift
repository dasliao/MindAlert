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
                    OnboardingProgressIndicator(totalSteps: 4, currentStep: 3)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 15) {
                            Image(systemName: "cross.case")
                                .foregroundStyle(MindAlertTheme.mindGreen)
                                .font(.system(size: 36, weight: .regular))
                            Text("Emergency Services")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(MindAlertTheme.mindBlack)
                        }
                        Spacer()
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

                        VStack(spacing: 20) {
                            // Call 911 option
                            Button {
                                useAlternative = false
                                viewModel.setEmergencyService("911")
                            } label: {
                                HStack {
                                    Image(systemName: !useAlternative ? "checkmark.circle.fill" : "circle")
                                    Text("Call 911")
                                }
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(!useAlternative ? .white : MindAlertTheme.mindPeach)
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                                .background(!useAlternative ? MindAlertTheme.mindPeach : .white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(MindAlertTheme.mindPeach, lineWidth: 2)
                                )
                            }

                            // Alternative service option
                            Button {
                                useAlternative = true
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: useAlternative ? "checkmark.circle.fill" : "circle")
                                        Text("I have an alternative emergency service")
                                    }
                                    .font(.system(size: 20, weight: .medium))

                                    if useAlternative {
                                        TextField("Enter service number", text: $alternativeService)
                                            .font(.system(size: 18))
                                            .keyboardType(.phonePad)
                                            .underlineTextField()
                                            .onChange(of: alternativeService) { _, newValue in
                                                if !newValue.isEmpty {
                                                    viewModel.setEmergencyService(newValue)
                                                }
                                            }
                                    }
                                }
                                .foregroundStyle(useAlternative ? .white : MindAlertTheme.mindPeach)
                                .padding(.leading, 20)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(useAlternative ? MindAlertTheme.mindPeach : .white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(MindAlertTheme.mindPeach, lineWidth: 2)
                                )
                            }
                        }

                        Spacer()
                        HStack {
                            Spacer()
                            Button("Confirm") { onNext() }
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
