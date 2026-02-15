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
                    }
                }
                .padding(.horizontal)

                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 10) {
                        Spacer()
                        Image(systemName: "person")
                            .font(.system(size: 40, weight: .regular))
                            .foregroundStyle(MindAlertTheme.mindGreen)
                        Text("What should we\ncall you?")
                            .font(.system(size: 32, weight: .semibold))
                        TextField("Your name", text: Binding(
                            get: { viewModel.safetyPlan.name },
                            set: { viewModel.setName($0) }
                        ))
                        .underlineTextField()
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Next") { onNext() }
                                .buttonStyle(GreenButton())
                            Spacer()
                        }
                    }
                    .mindAlertCard()

                    Text("Have an Account? Sign In")
                        .fontWeight(.bold)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                        .padding(.all)
                }
            }
            .padding(20)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
