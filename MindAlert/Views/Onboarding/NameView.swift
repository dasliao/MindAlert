import SwiftUI

struct NameView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                // Header
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._4) {
                    Text("Welcome to")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.textPrimary)
                    HStack(spacing: 0) {
                        Text("Mind")
                            .font(.maLargeTitle)
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        Text("Alert")
                            .font(.maLargeTitle)
                            .foregroundStyle(MindAlertTheme.mindPeach)
                        Text("!")
                            .font(.maLargeTitle)
                            .foregroundStyle(MindAlertTheme.textPrimary)
                    }
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)

                Spacer()

                // Name input section
                VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._12) {
                    Image(systemName: "person")
                        .font(.system(size: 36))
                        .foregroundStyle(MindAlertTheme.mindGreen)

                    Text("What should\nwe call you?")
                        .font(.maSplashBody)
                        .foregroundStyle(MindAlertTheme.textPrimary)

                    TextField("Your name", text: Binding(
                        get: { viewModel.safetyPlan.name },
                        set: { viewModel.setName($0) }
                    ))
                    .font(.maSplashBody)
                    .foregroundStyle(MindAlertTheme.mindPeach)
                    .underlineTextField()
                }
                .padding(.horizontal, MindAlertTheme.Spacing._24)

                Spacer()

                // Bottom buttons
                VStack(spacing: MindAlertTheme.Spacing._12) {
                    Button("Next") { onNext() }
                        .buttonStyle(GreenButton(disabled: viewModel.safetyPlan.name.trimmingCharacters(in: .whitespaces).isEmpty))
                        .disabled(viewModel.safetyPlan.name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, MindAlertTheme.Spacing._16)
            }
            .padding(.vertical, MindAlertTheme.Spacing._24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
