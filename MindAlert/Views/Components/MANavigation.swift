import SwiftUI

/// Navigation bar component.
/// Matches Play component: Navigation
/// Variants:
///   - `.default`: back chevron + title
///   - `.titleOnly`: just a centered title (no back button)
///   - `.backOnly`: back chevron, no title
enum MANavigationVariant {
    case `default`   // back + title (left-aligned title)
    case titleOnly   // centered title only
    case backOnly    // just back chevron
}

struct MANavigation: View {
    var title: String = ""
    var variant: MANavigationVariant = .default
    var onBack: (() -> Void)?
    var trailing: AnyView? = nil

    var body: some View {
        ZStack {
            // Title
            if variant != .backOnly, !title.isEmpty {
                Text(title)
                    .font(.maHeadline)
                    .foregroundColor(MindAlertTheme.textPrimary)
                    .frame(maxWidth: .infinity, alignment: variant == .titleOnly ? .center : .leading)
                    .padding(.leading, variant == .default ? 44 : 0)
            }

            HStack {
                // Back button
                if variant != .titleOnly, let onBack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(MindAlertTheme.textPrimary)
                            .frame(width: 44, height: 44)
                    }
                }

                Spacer()

                // Trailing
                if let trailing {
                    trailing
                }
            }
        }
        .frame(height: 44)
        .padding(.horizontal, MindAlertTheme.Spacing._8)
    }
}

#Preview {
    VStack(spacing: 0) {
        MANavigation(title: "Safety Plan", onBack: {})
        Divider()
        MANavigation(title: "Centered Title", variant: .titleOnly)
        Divider()
        MANavigation(variant: .backOnly, onBack: {})
    }
}
