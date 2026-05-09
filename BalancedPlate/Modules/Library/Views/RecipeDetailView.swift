import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Yields \(recipe.yield) servings")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        ForEach(recipe.nutritionalStrategyTags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.accentColor.opacity(0.2))
                                .foregroundColor(.accentColor)
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Ingredients
                VStack(alignment: .leading, spacing: 16) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                                .font(.body)
                            Spacer()
                            Text("\(ingredient.displayAmount, specifier: "%.1f") \(ingredient.displayUnit)")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.surface)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
                
                // Action
                Button {
                    // Log meal logic
                } label: {
                    Text(String(localized: "recipe.button.log"))
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.primaryBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
