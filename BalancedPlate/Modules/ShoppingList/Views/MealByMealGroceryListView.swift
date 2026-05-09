import SwiftUI

struct MealByMealGroceryListView: View {
    @Bindable var viewModel: ShoppingListViewModel
    
    var body: some View {
        let recipes = viewModel.plannedRecipes
        
        if recipes.isEmpty {
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "cart.badge.minus")
                    .font(.system(size: 64))
                    .foregroundColor(.gray)
                Text(String(localized: "shopping.empty.text"))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Spacer()
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 24, pinnedViews: .sectionHeaders) {
                    ForEach(recipes) { recipe in
                        Section {
                            VStack(spacing: 12) {
                                let ingredients = filteredIngredients(for: recipe)
                                if ingredients.isEmpty {
                                    Text("All ingredients are in your pantry!")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .padding()
                                } else {
                                    ForEach(ingredients) { ingredient in
                                        let idString = "\(recipe.id)_\(ingredient.id)"
                                        let hashId = UUID(uuidString: String(idString.md5.prefix(32))) ?? UUID() // Deterministic ID for mock
                                        let isChecked = viewModel.checkedIngredients.contains(hashId)
                                        
                                        Button {
                                            withAnimation {
                                                viewModel.toggleCheck(for: hashId)
                                            }
                                        } label: {
                                            HStack {
                                                Text(ingredient.name)
                                                    .font(.headline)
                                                    .strikethrough(isChecked, color: .secondary)
                                                    .foregroundColor(isChecked ? .secondary : .primary)
                                                
                                                Spacer()
                                                
                                                Text("\(ingredient.displayAmount, specifier: "%.1f") \(ingredient.displayUnit)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                
                                                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                                                    .foregroundColor(isChecked ? .accentColor : .gray)
                                                    .padding(.leading, 8)
                                            }
                                            .padding()
                                            .background(Color.surfaceColor)
                                            .cornerRadius(12)
                                            .opacity(isChecked ? 0.6 : 1.0)
                                        }
                                    }
                                }
                            }
                        } header: {
                            HStack {
                                Text(recipe.name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding()
                            .background(Color.primaryBackground)
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    private func filteredIngredients(for recipe: Recipe) -> [Ingredient] {
        return recipe.ingredients.filter { ingredient in
            if viewModel.hidePantryItems {
                return !viewModel.pantryItems.contains { $0.name.lowercased() == ingredient.name.lowercased() && $0.isInStock }
            }
            return true
        }
    }
}

// Simple MD5 mock for deterministic UUIDs in UI
import CryptoKit
extension String {
    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
