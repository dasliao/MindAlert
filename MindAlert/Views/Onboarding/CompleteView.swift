import SwiftUI

struct CompleteView: View {
    @ObservedObject var viewModel: SafetyPlanViewModel
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            MindAlertTheme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(MindAlertTheme.mindGreen)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 70, weight: .light))
                                .foregroundStyle(MindAlertTheme.mindGreen)

                            HStack(spacing: 0) {
                                Text("You did it ")
                                Text(viewModel.safetyPlan.name)
                                Text("!")
                            }
                        }
                        .foregroundStyle(MindAlertTheme.mindBlack)
                        .font(.system(size: 32, weight: .semibold))
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Done") {
                                viewModel.save()
                                onFinish()
                            }
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
