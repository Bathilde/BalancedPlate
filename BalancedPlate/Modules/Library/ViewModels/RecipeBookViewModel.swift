import Foundation
import SwiftData
import Observation

enum RecipeBookViewMode {
    case recipes
    case pantry
}

@Observable
final class RecipeBookViewModel {
    var viewMode: RecipeBookViewMode = .recipes
    var isExplorePresented: Bool = false

    var recipes: [Recipe] = []
    var pantryItems: [PantryItem] = []
    var exploreRecipes: [Recipe] = []

    func loadData(context: ModelContext) {
        do {
            self.recipes = try context.fetch(FetchDescriptor<Recipe>())
            self.pantryItems = try context.fetch(FetchDescriptor<PantryItem>())

            if self.recipes.isEmpty {
                self.recipes = [
                    Recipe(
                        name: "Morning Oatmeal",
                        yield: 1,
                        nutritionalStrategyTags: ["Iron", "B12"],
                        ingredients: [
                            Ingredient(name: "Oats", rawInputUnit: "1 cup", standardizedWeightGrams: 90, displayAmount: 1, displayUnit: "cup"),
                            Ingredient(name: "Milk", rawInputUnit: "200ml", standardizedWeightGrams: 200, displayAmount: 200, displayUnit: "ml")
                        ]
                    ),
                    Recipe(
                        name: "Spinach Power Omelette",
                        yield: 1,
                        nutritionalStrategyTags: ["Iron", "Vit D", "Calcium"],
                        ingredients: [
                            Ingredient(name: "Eggs", rawInputUnit: "2", standardizedWeightGrams: 120, displayAmount: 2, displayUnit: "large"),
                            Ingredient(name: "Spinach", rawInputUnit: "1 cup", standardizedWeightGrams: 30, displayAmount: 1, displayUnit: "cup")
                        ]
                    )
                ]
            }
            if self.pantryItems.isEmpty {
                self.pantryItems = [
                    PantryItem(name: "Olive Oil", isInStock: true),
                    PantryItem(name: "Rice", isInStock: false)
                ]
            }

            // Mock explore recipes (distinct from saved ones)
            self.exploreRecipes = [
                Recipe(
                    name: "Lentil & Kale Soup",
                    yield: 4,
                    nutritionalStrategyTags: ["Iron", "Mg", "Vit C"],
                    ingredients: [
                        Ingredient(name: "Red Lentils", rawInputUnit: "200g", standardizedWeightGrams: 200, displayAmount: 200, displayUnit: "g"),
                        Ingredient(name: "Kale", rawInputUnit: "100g", standardizedWeightGrams: 100, displayAmount: 100, displayUnit: "g")
                    ]
                ),
                Recipe(
                    name: "Salmon with Sweet Potato",
                    yield: 2,
                    nutritionalStrategyTags: ["Vit D", "B12", "Zinc"],
                    ingredients: [
                        Ingredient(name: "Salmon Fillet", rawInputUnit: "300g", standardizedWeightGrams: 300, displayAmount: 300, displayUnit: "g"),
                        Ingredient(name: "Sweet Potato", rawInputUnit: "1 large", standardizedWeightGrams: 200, displayAmount: 1, displayUnit: "large")
                    ]
                ),
                Recipe(
                    name: "Chickpea & Turmeric Stew",
                    yield: 3,
                    nutritionalStrategyTags: ["Iron", "Mg"],
                    ingredients: [
                        Ingredient(name: "Chickpeas", rawInputUnit: "400g", standardizedWeightGrams: 400, displayAmount: 400, displayUnit: "g"),
                        Ingredient(name: "Turmeric", rawInputUnit: "1 tsp", standardizedWeightGrams: 3, displayAmount: 1, displayUnit: "tsp")
                    ]
                )
            ]
        } catch {
            print("Failed to load recipe book: \(error)")
        }
    }

    func addToRecipeBook(_ recipe: Recipe, context: ModelContext) {
        context.insert(recipe)
        recipes.append(recipe)
    }

    func togglePantryStatus(for item: PantryItem, in context: ModelContext) {
        item.isInStock.toggle()
        try? context.save()
    }
}
