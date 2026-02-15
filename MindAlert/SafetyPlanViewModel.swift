import SwiftUI

@MainActor
class SafetyPlanViewModel: ObservableObject {
    @Published var safetyPlan: SafetyPlan

    init() {
        if let savedPlan = SafetyPlanStorage.shared.loadSafetyPlan() {
            self.safetyPlan = savedPlan
        } else {
            self.safetyPlan = SafetyPlan(
                name: "",
                strategies: [],
                contacts: [],
                emergencyService: "911",
                emergencyMessage: SafetyPlan.defaultEmergencyMessage
            )
        }
    }

    var hasSavedPlan: Bool {
        !safetyPlan.name.isEmpty && !safetyPlan.contacts.isEmpty
    }

    func save() {
        SafetyPlanStorage.shared.saveSafetyPlan(safetyPlan)
    }

    func addStrategy(_ strategy: String) {
        safetyPlan.strategies.append(strategy)
        save()
    }

    func removeStrategy(at index: Int) {
        guard index < safetyPlan.strategies.count else { return }
        safetyPlan.strategies.remove(at: index)
        save()
    }

    func addContact(name: String, phoneNumber: String) {
        let newContact = SafetyPlan.Contact(name: name, phoneNumber: phoneNumber)
        safetyPlan.contacts.append(newContact)
        save()
    }

    func removeContact(at index: Int) {
        guard index < safetyPlan.contacts.count else { return }
        safetyPlan.contacts.remove(at: index)
        save()
    }

    func setEmergencyService(_ service: String) {
        safetyPlan.emergencyService = service
        save()
    }

    func setName(_ name: String) {
        safetyPlan.name = name
        save()
    }

    func setEmergencyMessage(_ message: String) {
        safetyPlan.emergencyMessage = message
        save()
    }

    func callContact(at index: Int) {
        guard index < safetyPlan.contacts.count else { return }
        let phone = safetyPlan.contacts[index].phoneNumber
        guard let url = URL(string: "tel://\(phone)") else { return }
        UIApplication.shared.open(url)
    }

    func callEmergencyService() {
        guard let url = URL(string: "tel://\(safetyPlan.emergencyService)") else { return }
        UIApplication.shared.open(url)
    }
}
