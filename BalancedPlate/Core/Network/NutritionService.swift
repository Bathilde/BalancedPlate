import Foundation

protocol NutritionServiceProtocol {
    func analyzeNaturalLanguage(query: String) async throws -> [Ingredient]
    func getBridgeMeals(deficiencyFocus: [Nutrient]) async throws -> [Recipe]
    func getRecipes(for ingredientName: String) async throws -> [Recipe]
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
    
    func getRecipes(for ingredientName: String) async throws -> [Recipe] {
        return [
            Recipe(name: "Roasted \(ingredientName)", yield: 2, nutritionalStrategyTags: ["Vitamin C", "Iron"], ingredients: [
                Ingredient(name: ingredientName, rawInputUnit: "1 whole", standardizedWeightGrams: 500, displayAmount: 1, displayUnit: "whole"),
                Ingredient(name: "Olive oil", rawInputUnit: "2 tbsp", standardizedWeightGrams: 28, displayAmount: 2, displayUnit: "tbsp")
            ]),
            Recipe(name: "\(ingredientName) Soup", yield: 4, nutritionalStrategyTags: ["Vitamin D"], ingredients: [
                Ingredient(name: ingredientName, rawInputUnit: "2 cups", standardizedWeightGrams: 300, displayAmount: 2, displayUnit: "cups"),
                Ingredient(name: "Vegetable Broth", rawInputUnit: "4 cups", standardizedWeightGrams: 900, displayAmount: 4, displayUnit: "cups")
            ])
        ]
    }
}
