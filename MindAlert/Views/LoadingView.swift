import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            MindAlertTheme.background
                .ignoresSafeArea()
            VStack(spacing: MindAlertTheme.Spacing._16) {
                Image("Logo_Color")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                HStack(spacing: 0) {
                    Text("Mind")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.mindGreen)
                    Text("Alert")
                        .font(.maLargeTitle)
                        .foregroundStyle(MindAlertTheme.mindPeach)
                }
            }
        }
    }
}
