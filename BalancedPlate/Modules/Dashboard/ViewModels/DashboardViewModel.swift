import Foundation
import SwiftData
import Observation

@Observable
final class DashboardViewModel {
    var loggedMeals: [Meal] = []
    var bridgeMeals: [Recipe] = []
    var isScarcityMode: Bool {
        return loggedMeals.count < 5
    }
    
    // Mock Data for Mosaic Fill (0.0 to 1.0)
    var mosaicFills: [Nutrient: Double] = [
        .iron: 0.3,
        .vitaminD: 0.8,
        .b12: 0.1,
        .calcium: 0.5,
        .magnesium: 0.2,
        .zinc: 0.9,
        .vitaminC: 0.6
    ]
    
    let nutritionService: NutritionServiceProtocol
    
    init(nutritionService: NutritionServiceProtocol = MockNutritionService()) {
        self.nutritionService = nutritionService
    }
    
    func loadDashboardData(context: ModelContext, userSettings: UserSetting) async {
        // Fetch meals from SwiftData
        let descriptor = FetchDescriptor<Meal>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        do {
            self.loggedMeals = try context.fetch(descriptor)
            
            // Mocking a few meals for the UI if empty
            if self.loggedMeals.isEmpty {
                self.loggedMeals = [
                    Meal(timestamp: Date().addingTimeInterval(-3600), ingredients: [
                        Ingredient(name: "Apple", rawInputUnit: "1", standardizedWeightGrams: 100, displayAmount: 1, displayUnit: "medium")
                    ]),
                    Meal(timestamp: Date().addingTimeInterval(-7200), ingredients: [
                        Ingredient(name: "Chicken", rawInputUnit: "1", standardizedWeightGrams: 200, displayAmount: 1, displayUnit: "breast")
                    ])
                ]
            }
            
            // Randomize fills for demonstration
            for nutrient in Nutrient.allCases {
                mosaicFills[nutrient] = Double.random(in: 0.2...0.9)
            }
            
            if !isScarcityMode {
                bridgeMeals = try await nutritionService.getBridgeMeals(deficiencyFocus: userSettings.deficiencyFocus)
            }
        } catch {
            print("Failed to load dashboard data: \(error)")
        }
    }
}

extension Nutrient: CaseIterable {
    public static var allCases: [Nutrient] {
        return [.iron, .vitaminD, .b12, .calcium, .magnesium, .zinc, .vitaminC]
    }
}
