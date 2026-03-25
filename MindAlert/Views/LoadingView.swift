import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            MindAlertTheme.background
                .ignoresSafeArea()
            VStack {
                Image("Logo_Color")
                HStack {
                    Text("Mind")
                        .font(.title.bold())
                        .foregroundStyle(MindAlertTheme.mindGreen)
                    Text("Alert")
                        .font(.title.bold())
                        .foregroundStyle(MindAlertTheme.mindPeach)
                }
            }
        }
    }
}
