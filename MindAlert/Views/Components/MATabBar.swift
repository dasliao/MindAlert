import SwiftUI

enum HomeTab: Equatable {
    case resources
    case home
    case profile
}

/// Custom 3-tab bottom bar.
/// Matches Play component: Tab_1
struct MATabBar: View {
    @Binding var selectedTab: HomeTab

    var body: some View {
        HStack(spacing: 0) {
            tabItem(tab: .resources, icon: "person.2.fill", label: "Resources")
            tabItem(tab: .home, icon: "house.fill", label: "Home")
            tabItem(tab: .profile, icon: "person.fill", label: "Profile")
        }
        .padding(.horizontal, MindAlertTheme.Spacing._8)
        .padding(.top, MindAlertTheme.Spacing._8)
        .padding(.bottom, MindAlertTheme.Spacing._4)
        .background(MindAlertTheme.white)
        .overlay(
            Rectangle()
                .fill(MindAlertTheme.borderSeparator)
                .frame(height: 0.5),
            alignment: .top
        )
    }

    @ViewBuilder
    private func tabItem(tab: HomeTab, icon: String, label: String) -> some View {
        let isSelected = selectedTab == tab
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: MindAlertTheme.Spacing._4) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.textTertiary)
                Text(label)
                    .font(.maTabCaption)
                    .foregroundColor(isSelected ? MindAlertTheme.mindGreen : MindAlertTheme.textTertiary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, MindAlertTheme.Spacing._4)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

#Preview {
    VStack {
        Spacer()
        MATabBar(selectedTab: .constant(.home))
    }
}
