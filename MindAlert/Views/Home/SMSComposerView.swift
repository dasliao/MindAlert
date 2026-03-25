import SwiftUI
import MessageUI

struct SMSComposerView: UIViewControllerRepresentable {
    let recipients: [String]
    let body: String
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.recipients = recipients
        controller.body = body
        controller.messageComposeDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    @MainActor
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        let parent: SMSComposerView

        init(_ parent: SMSComposerView) {
            self.parent = parent
        }

        nonisolated func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            Task { @MainActor in
                parent.isPresented = false
            }
        }
    }
}
