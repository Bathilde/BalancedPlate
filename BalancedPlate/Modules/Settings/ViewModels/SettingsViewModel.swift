import Foundation
import SwiftData
import Observation

@Observable
final class SettingsViewModel {
    var userSetting: UserSetting?
    
    // Form Bindings
    var householdSize: Int = 1
    var unitSystem: UnitSystem = .metric
    
    func loadData(context: ModelContext) {
        do {
            let settings = try context.fetch(FetchDescriptor<UserSetting>())
            if let setting = settings.first {
                self.userSetting = setting
                self.householdSize = setting.householdSize
                self.unitSystem = setting.preferredUnitSystem
            }
        } catch {
            print("Failed to load settings: \(error)")
        }
    }
    
    func saveSettings(context: ModelContext) {
        guard let setting = userSetting else { return }
        setting.householdSize = householdSize
        setting.preferredUnitSystem = unitSystem
        try? context.save()
    }
}
