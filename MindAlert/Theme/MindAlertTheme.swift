import SwiftUI

enum MindAlertTheme {
    // Primary colors from Assets.xcassets
    static let mindGreen = Color("MindGreen")
    static let mindPeach = Color("MindPeach")
    static let mindLightGreen = Color("MindLightGreen")
    static let mindLightPeach = Color("MindLightPeach")
    static let mindBlack = Color("MindBlack")
    static let mindWhite = Color("MindWhite")
    static let mindPeachWhite = Color("MindPeachWhite")

    // Semantic colors
    static let background = Color(red: 0.96, green: 0.96, blue: 0.96)
    static let cardBackground = Color.white

    // Glass tint colors
    static let greenGlassTint = Color("MindGreen").opacity(0.15)
    static let peachGlassTint = Color("MindPeach").opacity(0.15)
}
