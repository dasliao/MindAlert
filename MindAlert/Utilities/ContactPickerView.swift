import SwiftUI
import ContactsUI

/// System contact picker using CNContactPickerViewController.
/// Requires no special entitlements or permissions.
struct ContactPickerView: UIViewControllerRepresentable {
    var onContactSelected: @MainActor (String, String) -> Void

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onContactSelected: onContactSelected)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        let onContactSelected: @MainActor (String, String) -> Void

        init(onContactSelected: @escaping @MainActor (String, String) -> Void) {
            self.onContactSelected = onContactSelected
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            let name = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
            let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
            guard !name.isEmpty && !phone.isEmpty else { return }
            let callback = onContactSelected
            DispatchQueue.main.async {
                callback(name, phone)
            }
        }
    }
}
