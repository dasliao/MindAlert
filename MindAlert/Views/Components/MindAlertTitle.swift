import SwiftUI

/// "Mind" in green + "Alert" in textPrimary — the brand colored title.
/// Matches Play component: MindAlertBrandColoredTitle
struct MindAlertTitle: View {
    var font: Font = .maLargeTitle

    var body: some View {
        (Text("Mind").foregroundColor(MindAlertTheme.mindGreen) +
         Text("Alert").foregroundColor(MindAlertTheme.textPrimary))
            .font(font)
    }
}

#Preview {
    MindAlertTitle()
}
