import Foundation

struct SafetyPlan: Codable {
    var name: String
    var email: String
    var termAgreed: Bool
    var strategies: [String]
    var contacts: [Contact]
    var professionalContacts: [Contact]
    var emergencyService: String
    var emergencyMessage: String?

    struct Contact: Codable, Identifiable {
        var id = UUID()
        var name: String
        var phoneNumber: String
    }

    // Custom decoder for backward compatibility
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = (try? container.decodeIfPresent(String.self, forKey: .email)) ?? ""
        termAgreed = (try? container.decodeIfPresent(Bool.self, forKey: .termAgreed)) ?? false
        strategies = try container.decode([String].self, forKey: .strategies)
        contacts = try container.decode([Contact].self, forKey: .contacts)
        professionalContacts = (try? container.decodeIfPresent([Contact].self, forKey: .professionalContacts)) ?? []
        emergencyService = try container.decode(String.self, forKey: .emergencyService)
        emergencyMessage = try container.decodeIfPresent(String.self, forKey: .emergencyMessage)
    }

    init(name: String = "",
         email: String = "",
         termAgreed: Bool = false,
         strategies: [String] = [],
         contacts: [Contact] = [],
         professionalContacts: [Contact] = [],
         emergencyService: String = "911",
         emergencyMessage: String? = nil) {
        self.name = name
        self.email = email
        self.termAgreed = termAgreed
        self.strategies = strategies
        self.contacts = contacts
        self.professionalContacts = professionalContacts
        self.emergencyService = emergencyService
        self.emergencyMessage = emergencyMessage
    }

    static let defaultEmergencyMessage = "Hello, I am not ok right now. I already contacted professional services, but you can help me by going through this process with me. Are you available to help me right now?"

    var resolvedEmergencyMessage: String {
        emergencyMessage ?? Self.defaultEmergencyMessage
    }
}

@MainActor
final class SafetyPlanStorage {
    static let shared = SafetyPlanStorage()
    private let userDefaults = UserDefaults.standard
    private let safetyPlanKey = "safetyPlan"

    func saveSafetyPlan(_ plan: SafetyPlan) {
        if let encoded = try? JSONEncoder().encode(plan) {
            userDefaults.set(encoded, forKey: safetyPlanKey)
        }
    }

    func loadSafetyPlan() -> SafetyPlan? {
        if let savedData = userDefaults.data(forKey: safetyPlanKey),
           let plan = try? JSONDecoder().decode(SafetyPlan.self, from: savedData) {
            return plan
        }
        return nil
    }

    func clearSafetyPlan() {
        userDefaults.removeObject(forKey: safetyPlanKey)
    }
}
