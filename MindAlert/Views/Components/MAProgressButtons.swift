import SwiftUI

/// Bottom progress button group.
/// Matches Play component: ProgressButtons
/// Variants match Play states: defaultState, primarySecondary_Vertical, primarySecondary_Horizontal, primaryTertiary
enum MAProgressButtonsVariant {
    case single                // one primary button
    case verticalStack         // primary on top, secondary below
    case horizontalStack       // secondary left, primary right
    case primaryWithTertiary   // primary + tertiary text link below
}

struct MAProgressButtons: View {
    var variant: MAProgressButtonsVariant = .single
    var primaryTitle: String = "Continue"
    var secondaryTitle: String = "Back"
    var tertiaryTitle: String = "Skip"
    var primaryEnabled: Bool = true
    var onPrimary: () -> Void
    var onSecondary: (() -> Void)? = nil
    var onTertiary: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: MindAlertTheme.Spacing._12) {
            switch variant {
            case .single:
                MAButton(title: primaryTitle, style: .primary, isEnabled: primaryEnabled, action: onPrimary)

            case .verticalStack:
                MAButton(title: primaryTitle, style: .primary, isEnabled: primaryEnabled, action: onPrimary)
                if let onSecondary {
                    MAButton(title: secondaryTitle, style: .secondary, action: onSecondary)
                }

            case .horizontalStack:
                HStack(spacing: MindAlertTheme.Spacing._12) {
                    if let onSecondary {
                        MAButton(title: secondaryTitle, style: .secondary, action: onSecondary)
                    }
                    MAButton(title: primaryTitle, style: .primary, isEnabled: primaryEnabled, action: onPrimary)
                }

            case .primaryWithTertiary:
                MAButton(title: primaryTitle, style: .primary, isEnabled: primaryEnabled, action: onPrimary)
                if let onTertiary {
                    Button(action: onTertiary) {
                        Text(tertiaryTitle)
                            .font(.maCaption)
                            .foregroundColor(MindAlertTheme.textSecondary)
                    }
                }
            }
        }
        .padding(.horizontal, MindAlertTheme.Spacing._24)
        .padding(.bottom, MindAlertTheme.Spacing._32)
    }
}

#Preview {
    VStack(spacing: 32) {
        MAProgressButtons(variant: .single, onPrimary: {})
        MAProgressButtons(variant: .verticalStack, onPrimary: {}, onSecondary: {})
        MAProgressButtons(variant: .horizontalStack, onPrimary: {}, onSecondary: {})
        MAProgressButtons(variant: .primaryWithTertiary, onPrimary: {}, onTertiary: {})
    }
    .padding(.top)
}
