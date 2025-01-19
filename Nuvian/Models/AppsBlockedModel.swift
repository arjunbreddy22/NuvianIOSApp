import Foundation
import FamilyControls
import Combine

class AppsBlockedModel: ObservableObject {
    static let shared = AppsBlockedModel()
    
    private let appGroupId = "group.com.arjun.nuvian"
    
    @Published var appsBlocked: FamilyActivitySelection
   
    
    private init() {
        // Initialize with empty selection first
        self.appsBlocked = FamilyActivitySelection()
       
        
        // Then try to load saved data
        if let savedSelection = loadSelection() {
            self.appsBlocked = savedSelection
        }
      
    }

    private func loadSelection() -> FamilyActivitySelection? {
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            print("Failed to access App Group UserDefaults")
            return nil
        }
        
        guard let data = userDefaults.data(forKey: "appsBlockedSelection") else {
            print("No saved selection found")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let selection = try decoder.decode(FamilyActivitySelection.self, from: data)
            print("Loaded selection with \(selection.applicationTokens.count) tokens")
            return selection
        } catch {
            print("Failed to decode selection: \(error)")
            return nil
        }
    }
    

    
}
