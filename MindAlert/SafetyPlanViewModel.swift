class SafetyPlanViewModel: ObservableObject {
    @Published var safetyPlan: SafetyPlan
    
    init() {
        // Try to load existing safety plan, or create a new one
        if let savedPlan = SafetyPlanStorage.shared.loadSafetyPlan() {
            self.safetyPlan = savedPlan
        } else {
            // Default empty plan
            self.safetyPlan = SafetyPlan(
                name: "",
                strategies: [],
                contacts: [],
                emergencyService: "911"
            )
        }
    }
    
    func save() {
        SafetyPlanStorage.shared.saveSafetyPlan(safetyPlan)
    }
    
    func addStrategy(_ strategy: String) {
        safetyPlan.strategies.append(strategy)
        save()
    }
    
    func removeStrategy(at index: Int) {
        if index < safetyPlan.strategies.count {
            safetyPlan.strategies.remove(at: index)
            save()
        }
    }
    
    func addContact(name: String, phoneNumber: String) {
        let newContact = SafetyPlan.Contact(name: name, phoneNumber: phoneNumber)
        safetyPlan.contacts.append(newContact)
        save()
    }
    
    func removeContact(at index: Int) {
        if index < safetyPlan.contacts.count {
            safetyPlan.contacts.remove(at: index)
            save()
        }
    }
    
    func setEmergencyService(_ service: String) {
        safetyPlan.emergencyService = service
        save()
    }
    
    func setName(_ name: String) {
        safetyPlan.name = name
        save()
    }
}