import SwiftUI

/// Contact card for display in lists.
/// Matches Play component: ContactCard
struct ContactCard: View {
    let name: String
    let phoneNumber: String
    var onDelete: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            // Avatar
            Circle()
                .fill(MindAlertTheme.whiteGreen)
                .frame(width: 44, height: 44)
                .overlay(
                    Text(initials)
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.mindGreen)
                )

            // Info
            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                Text(name)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.textPrimary)
                Text(phoneNumber)
                    .font(.maCaption)
                    .foregroundColor(MindAlertTheme.textSecondary)
            }

            Spacer()

            // Delete button
            if let onDelete {
                Button(action: onDelete) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(MindAlertTheme.mindPeach)
                }
            }
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.white)
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }

    private var initials: String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1)) + String(parts[1].prefix(1))
        }
        return String(name.prefix(2)).uppercased()
    }
}

/// Highlighted contact card shown during PlanActivated.
/// Matches Play component: ContactCardActivated
struct ContactCardActivated: View {
    let name: String
    let phoneNumber: String
    var onCall: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: MindAlertTheme.Spacing._12) {
            Circle()
                .fill(MindAlertTheme.staticWhite.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay(
                    Text(initials)
                        .font(.maBoldBody)
                        .foregroundColor(MindAlertTheme.staticWhite)
                )

            VStack(alignment: .leading, spacing: MindAlertTheme.Spacing._2) {
                Text(name)
                    .font(.maBoldBody)
                    .foregroundColor(MindAlertTheme.staticWhite)
                Text(phoneNumber)
                    .font(.maCaption)
                    .foregroundColor(MindAlertTheme.staticWhite.opacity(0.8))
            }

            Spacer()

            if let onCall {
                Button(action: onCall) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 18))
                        .foregroundColor(MindAlertTheme.staticWhite)
                        .frame(width: 44, height: 44)
                        .background(MindAlertTheme.staticWhite.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
        .padding(MindAlertTheme.Spacing._16)
        .background(MindAlertTheme.mindGreen.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: MindAlertTheme.Radius._16))
    }

    private var initials: String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1)) + String(parts[1].prefix(1))
        }
        return String(name.prefix(2)).uppercased()
    }
}

#Preview {
    VStack(spacing: 12) {
        ContactCard(name: "Alex Johnson", phoneNumber: "(555) 123-4567", onDelete: {})
        ContactCardActivated(name: "Alex Johnson", phoneNumber: "(555) 123-4567", onCall: {})
    }
    .padding()
    .background(MindAlertTheme.lightGray)
}
