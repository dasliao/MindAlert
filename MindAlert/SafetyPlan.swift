// Updated data model that allows for variable numbers of strategies and contacts
struct SafetyPlan: Codable {
    var name: String
    var strategies: [String]
    var contacts: [Contact]
    var emergencyService: String
    
    struct Contact: Codable, Identifiable {
        var id = UUID()
        var name: String
        var phoneNumber: String
    }
}

// Storage manager to handle saving and retrieving data
class SafetyPlanStorage {
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