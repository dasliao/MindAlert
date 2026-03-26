import SwiftUI

/// App logo component.
/// Matches Play component: Logo
/// - `onAccent`: white logo for use on colored backgrounds
struct MALogo: View {
    var onAccent: Bool = false
    var size: CGFloat = 48

    var body: some View {
        Image(onAccent ? "Logo_White" : "Logo_Color")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    VStack(spacing: 24) {
        MALogo()
        MALogo(onAccent: true)
            .padding()
            .background(MindAlertTheme.mindGreen)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
