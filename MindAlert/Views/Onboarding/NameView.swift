import SwiftUI

struct NameView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onNext: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Welcome to")
                        .font(.system(size: 40, weight: .bold))
                    HStack(spacing: 0) {
                        Text("Mind")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        Text("Alert")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(MindAlertTheme.mindPeach)
                        Text("!")
                            .font(.system(size: 40, weight: .bold))
                    }
                }
                .padding(.horizontal)

                Spacer()

                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: "person")
                        .font(.system(size: 40, weight: .regular))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                    Text("What should\nwe call you?")
                        .font(.system(size: 32, weight: .semibold))
                    TextField("Your name", text: Binding(
                        get: { viewModel.safetyPlan.name },
                        set: { viewModel.setName($0) }
                    ))
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(MindAlertTheme.mindPeach)
                    .underlineTextField()
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 12) {
                    Button("Next") { onNext() }
                        .buttonStyle(GreenButton())
                    Text("Already have an Account? Sign In")
                        .fontWeight(.bold)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
