import Foundation

protocol NutritionServiceProtocol {
    func analyzeNaturalLanguage(query: String) async throws -> [Ingredient]
    func getBridgeMeals(deficiencyFocus: [Nutrient]) async throws -> [Recipe]
}

class MockNutritionService: NutritionServiceProtocol {
    func analyzeNaturalLanguage(query: String) async throws -> [Ingredient] {
        // Mock data
        return [
            Ingredient(name: "Apple", rawInputUnit: "1 medium", standardizedWeightGrams: 182, displayAmount: 1, displayUnit: "medium"),
            Ingredient(name: "Spinach", rawInputUnit: "1 cup", standardizedWeightGrams: 30, displayAmount: 1, displayUnit: "cup")
        ]
    }
    
    func getBridgeMeals(deficiencyFocus: [Nutrient]) async throws -> [Recipe] {
        // Mock data
        return [
            Recipe(name: "Iron-Rich Spinach Salad", yield: 1, nutritionalStrategyTags: ["Iron"], ingredients: [
                Ingredient(name: "Spinach", rawInputUnit: "2 cups", standardizedWeightGrams: 60, displayAmount: 2, displayUnit: "cups")
            ])
        ]
    }
}
