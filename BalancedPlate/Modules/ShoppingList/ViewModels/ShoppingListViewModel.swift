import Foundation
import SwiftData
import Observation

enum ShoppingViewMode {
    case global
    case mealByMeal
}

struct ConsolidatedIngredient: Identifiable {
    let id = UUID()
    let name: String
    var totalAmount: Double
    let unit: String
    var isChecked: Bool = false
}

@Observable
final class ShoppingListViewModel {
    var viewMode: ShoppingViewMode = .global
    var hidePantryItems: Bool = true
    
    var plannedRecipes: [Recipe] = []
    var pantryItems: [PantryItem] = []
    
    // Internal state for strikethrough in UI (ephemeral)
    var checkedIngredients: Set<UUID> = []
    
    func loadData(context: ModelContext) {
        do {
            self.plannedRecipes = try context.fetch(FetchDescriptor<Recipe>())
            self.pantryItems = try context.fetch(FetchDescriptor<PantryItem>())
            
            // Generate mock data if empty to show the UI
            if self.plannedRecipes.isEmpty {
                let mockRecipe1 = Recipe(name: "Spinach Salad", yield: 2, ingredients: [
                    Ingredient(name: "Spinach", rawInputUnit: "1 cup", standardizedWeightGrams: 30, displayAmount: 1, displayUnit: "cup"),
                    Ingredient(name: "Olive Oil", rawInputUnit: "1 tbsp", standardizedWeightGrams: 14, displayAmount: 1, displayUnit: "tbsp")
                ])
                let mockRecipe2 = Recipe(name: "Roasted Veggies", yield: 2, ingredients: [
                    Ingredient(name: "Carrots", rawInputUnit: "2 whole", standardizedWeightGrams: 150, displayAmount: 2, displayUnit: "whole"),
                    Ingredient(name: "Olive Oil", rawInputUnit: "2 tbsp", standardizedWeightGrams: 28, displayAmount: 2, displayUnit: "tbsp")
                ])
                self.plannedRecipes = [mockRecipe1, mockRecipe2]
            }
            
            if self.pantryItems.isEmpty {
                self.pantryItems = [
                    PantryItem(name: "Olive Oil", isInStock: true)
                ]
            }
            
        } catch {
            print("Error loading shopping list data: \(error)")
        }
    }
    
    var consolidatedIngredients: [ConsolidatedIngredient] {
        var dictionary: [String: ConsolidatedIngredient] = [:]
        
        for recipe in plannedRecipes {
            for ingredient in recipe.ingredients {
                // Filter by pantry if enabled
                if hidePantryItems, pantryItems.contains(where: { $0.name.lowercased() == ingredient.name.lowercased() && $0.isInStock }) {
                    continue
                }
                
                let key = ingredient.name.lowercased() + "_" + ingredient.displayUnit.lowercased()
                if var existing = dictionary[key] {
                    existing.totalAmount += ingredient.displayAmount
                    dictionary[key] = existing
                } else {
                    dictionary[key] = ConsolidatedIngredient(name: ingredient.name, totalAmount: ingredient.displayAmount, unit: ingredient.displayUnit)
                }
            }
        }
        
        return Array(dictionary.values).sorted(by: { $0.name < $1.name })
    }
    
    func toggleCheck(for id: UUID) {
        if checkedIngredients.contains(id) {
            checkedIngredients.remove(id)
        } else {
            checkedIngredients.insert(id)
        }
    }
}
