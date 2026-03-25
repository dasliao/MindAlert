import SwiftUI
import UIKit

// MARK: - Adaptive Color Helper

private func adaptiveColor(light: UIColor, dark: UIColor? = nil) -> Color {
    Color(uiColor: UIColor { traitCollection in
        (traitCollection.userInterfaceStyle == .dark) ? (dark ?? light) : light
    })
}

// MARK: - Design Tokens (from Play export)

enum MindAlertTheme {

    // MARK: Primary Colors (adaptive light/dark)

    static let black = adaptiveColor(
        light: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0),
        dark: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    )
    static let white = adaptiveColor(
        light: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        dark: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    )

    // MARK: Gray

    static let lightGray = adaptiveColor(
        light: UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.0),
        dark: UIColor(red: 0.114, green: 0.114, blue: 0.114, alpha: 1.0)
    )

    // MARK: Text Colors

    static let textPrimary = adaptiveColor(
        light: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0),
        dark: UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.0)
    )
    static let textSecondary = adaptiveColor(
        light: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0),
        dark: UIColor(red: 0.692, green: 0.692, blue: 0.692, alpha: 1.0)
    )
    static let textTertiary = adaptiveColor(
        light: UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1.0),
        dark: UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.0)
    )

    // MARK: Green Palette

    static let mindGreen = adaptiveColor(
        light: UIColor(red: 0.459, green: 0.604, blue: 0.420, alpha: 1.0),
        dark: UIColor(red: 0.522, green: 0.690, blue: 0.471, alpha: 1.0)
    )
    static let mindLightGreen = adaptiveColor(
        light: UIColor(red: 0.714, green: 0.8, blue: 0.561, alpha: 1.0),
        dark: UIColor(red: 0.749, green: 0.835, blue: 0.592, alpha: 1.0)
    )
    static let whiteGreen = adaptiveColor(
        light: UIColor(red: 0.955, green: 0.966, blue: 0.938, alpha: 1.0),
        dark: UIColor(red: 0.141, green: 0.153, blue: 0.125, alpha: 1.0)
    )

    // MARK: Peach Palette

    static let mindPeach = adaptiveColor(
        light: UIColor(red: 0.949, green: 0.702, blue: 0.6, alpha: 1.0),
        dark: UIColor(red: 0.929, green: 0.682, blue: 0.580, alpha: 1.0)
    )
    static let darkPeach = adaptiveColor(
        light: UIColor(red: 0.820, green: 0.549, blue: 0.433, alpha: 1.0),
        dark: UIColor(red: 0.835, green: 0.562, blue: 0.445, alpha: 1.0)
    )
    static let mindLightPeach = adaptiveColor(
        light: UIColor(red: 0.937, green: 0.847, blue: 0.808, alpha: 1.0),
        dark: UIColor(red: 0.345, green: 0.260, blue: 0.221, alpha: 1.0)
    )
    static let mindPeachWhite = adaptiveColor(
        light: UIColor(red: 1.0, green: 0.976, blue: 0.965, alpha: 1.0),
        dark: UIColor(red: 0.165, green: 0.137, blue: 0.125, alpha: 1.0)
    )

    // MARK: Static Colors (no dark mode change)

    static let staticWhite = Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    static let staticBlack = Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))

    // MARK: UI State Colors

    static let buttonDisable = adaptiveColor(
        light: UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1.0),
        dark: UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1.0)
    )
    static let borderSeparator = adaptiveColor(
        light: UIColor(red: 0.914, green: 0.914, blue: 0.914, alpha: 1.0),
        dark: UIColor(red: 0.210, green: 0.210, blue: 0.210, alpha: 1.0)
    )

    // MARK: Semantic Colors

    static let background = lightGray
    static let cardBackground = white
    static let backgroundPrimary = adaptiveColor(
        light: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3),
        dark: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
    )

    // MARK: Legacy aliases (keep existing references working)

    static let mindBlack = textPrimary
    static let mindWhite = white

    // MARK: Glass tint colors

    static let greenGlassTint = mindGreen.opacity(0.15)
    static let peachGlassTint = mindPeach.opacity(0.15)

    // MARK: - Gradients

    static let greenGradient = LinearGradient(
        colors: [mindLightGreen, mindGreen],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let peachGradient = LinearGradient(
        colors: [mindPeach, mindLightPeach],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Spacing

    enum Spacing {
        static let _0: CGFloat = 0
        static let _1: CGFloat = 1
        static let _2: CGFloat = 2
        static let _4: CGFloat = 4
        static let _8: CGFloat = 8
        static let _12: CGFloat = 12
        static let _16: CGFloat = 16
        static let _24: CGFloat = 24
        static let _32: CGFloat = 32
        static let _48: CGFloat = 48
        static let _64: CGFloat = 64
        static let _128: CGFloat = 128
    }

    // MARK: - Corner Radius

    enum Radius {
        static let _0: CGFloat = 0
        static let _4: CGFloat = 4
        static let _8: CGFloat = 8
        static let _12: CGFloat = 12
        static let _16: CGFloat = 16
        static let _24: CGFloat = 24
        static let _32: CGFloat = 32
        static let _40: CGFloat = 40
        static let _48: CGFloat = 48
        static let _56: CGFloat = 56
        static let _64: CGFloat = 64
    }
}

// MARK: - Typography

/// Play export font weight mapping:
/// 0.0  = .regular
/// 0.23 = .medium
/// 0.30 = .semibold
///
/// Play export font design:
/// NSCTFontUIFontDesignDefault  = .default
/// NSCTFontUIFontDesignRounded  = .rounded

extension Font {
    /// 32pt System Rounded Semibold
    static let maLargeTitle: Font = .system(size: 32, weight: .semibold, design: .rounded)
    /// 34pt System Rounded Semibold
    static let maSafetyPlanTitle: Font = .system(size: 34, weight: .semibold, design: .rounded)
    /// 28pt System Default Semibold, lineHeight 32
    static let maSplashBody: Font = .system(size: 28, weight: .semibold)
    /// 22pt System Default Semibold
    static let maPageHeaderSmall: Font = .system(size: 22, weight: .semibold)
    /// 19pt System Default Semibold
    static let maHeadline: Font = .system(size: 19, weight: .semibold)
    /// 19pt System Rounded Medium, lineHeight 24
    static let maSafetyPlanBody: Font = .system(size: 19, weight: .medium, design: .rounded)
    /// 17pt System Default Medium, lineHeight 24
    static let maBoldBody: Font = .system(size: 17, weight: .medium)
    /// 15pt System Default Regular
    static let maCaption: Font = .system(size: 15, weight: .regular)
    /// 12pt System Default Medium
    static let maTabCaption: Font = .system(size: 12, weight: .medium)
}
