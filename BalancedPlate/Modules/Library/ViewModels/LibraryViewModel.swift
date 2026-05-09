import Foundation
import SwiftData
import Observation

enum LibraryViewMode {
    case recipes
    case pantry
}

@Observable
final class LibraryViewModel {
    var viewMode: LibraryViewMode = .recipes
    
    var recipes: [Recipe] = []
    var pantryItems: [PantryItem] = []
    
    func loadData(context: ModelContext) {
        do {
            self.recipes = try context.fetch(FetchDescriptor<Recipe>())
            self.pantryItems = try context.fetch(FetchDescriptor<PantryItem>())
            
            // Mock data if empty
            if self.recipes.isEmpty {
                self.recipes = [
                    Recipe(name: "Morning Oatmeal", yield: 1, nutritionalStrategyTags: ["Iron"], ingredients: [
                        Ingredient(name: "Oats", rawInputUnit: "1 cup", standardizedWeightGrams: 90, displayAmount: 1, displayUnit: "cup")
                    ])
                ]
            }
            if self.pantryItems.isEmpty {
                self.pantryItems = [
                    PantryItem(name: "Olive Oil", isInStock: true),
                    PantryItem(name: "Rice", isInStock: false)
                ]
            }
        } catch {
            print("Failed to load library: \(error)")
        }
    }
    
    func togglePantryStatus(for item: PantryItem, in context: ModelContext) {
        item.isInStock.toggle()
        try? context.save()
    }
}
