import SwiftUI

@MainActor
class SafetyPlanViewModel: ObservableObject {
    @Published var safetyPlan: SafetyPlan

    init() {
        if let savedPlan = SafetyPlanStorage.shared.loadSafetyPlan() {
            self.safetyPlan = savedPlan
        } else {
            self.safetyPlan = SafetyPlan()
        }
    }

    // MARK: - Computed

    var hasSavedPlan: Bool {
        !safetyPlan.name.isEmpty
    }

    // MARK: - Persistence

    func save() {
        SafetyPlanStorage.shared.saveSafetyPlan(safetyPlan)
    }

    // MARK: - Profile

    func setName(_ name: String) {
        safetyPlan.name = name
        save()
    }

    func setEmail(_ email: String) {
        safetyPlan.email = email
        save()
    }

    func setTermAgreed(_ agreed: Bool) {
        safetyPlan.termAgreed = agreed
        save()
    }

    // MARK: - Coping Strategies

    func addStrategy(_ strategy: String) {
        safetyPlan.strategies.append(strategy)
        save()
    }

    func removeStrategy(at index: Int) {
        guard index < safetyPlan.strategies.count else { return }
        safetyPlan.strategies.remove(at: index)
        save()
    }

    func updateStrategy(_ strategy: String, at index: Int) {
        guard index < safetyPlan.strategies.count else { return }
        safetyPlan.strategies[index] = strategy
        save()
    }

    // MARK: - Trust Contacts (PeopleThatHelp)

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

    // MARK: - Professional Contacts (ProfessionalSupport)

    func addProfessionalContact(name: String, phoneNumber: String) {
        let newContact = SafetyPlan.Contact(name: name, phoneNumber: phoneNumber)
        safetyPlan.professionalContacts.append(newContact)
        save()
    }

    func removeProfessionalContact(at index: Int) {
        guard index < safetyPlan.professionalContacts.count else { return }
        safetyPlan.professionalContacts.remove(at: index)
        save()
    }

    // MARK: - Emergency Service

    func setEmergencyService(_ service: String) {
        safetyPlan.emergencyService = service
        save()
    }

    func setEmergencyMessage(_ message: String) {
        safetyPlan.emergencyMessage = message
        save()
    }

    // MARK: - Actions

    func callContact(at index: Int) {
        guard index < safetyPlan.contacts.count else { return }
        let phone = safetyPlan.contacts[index].phoneNumber
        guard let url = URL(string: "tel://\(phone)") else { return }
        UIApplication.shared.open(url)
    }

    func callProfessionalContact(at index: Int) {
        guard index < safetyPlan.professionalContacts.count else { return }
        let phone = safetyPlan.professionalContacts[index].phoneNumber
        guard let url = URL(string: "tel://\(phone)") else { return }
        UIApplication.shared.open(url)
    }

    func callEmergencyService() {
        let number = safetyPlan.emergencyService == "988" ? "988" : "911"
        guard let url = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(url)
    }

    // MARK: - Reset

    func clearSavedPlan() {
        SafetyPlanStorage.shared.clearSafetyPlan()
        safetyPlan = SafetyPlan()
    }
}
