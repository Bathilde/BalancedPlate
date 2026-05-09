import SwiftUI

// MARK: - RecipeBookView
struct RecipeBookView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = RecipeBookViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()

                VStack(spacing: 0) {
                    Picker("View Mode", selection: $viewModel.viewMode) {
                        Text(String(localized: "recipebook.picker.recipes")).tag(RecipeBookViewMode.recipes)
                        Text(String(localized: "recipebook.picker.pantry")).tag(RecipeBookViewMode.pantry)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    if viewModel.viewMode == .recipes {
                        RecipesListView(viewModel: viewModel)
                    } else {
                        PantryListView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle(String(localized: "recipebook.main.text.title"))
            .onAppear {
                viewModel.loadData(context: modelContext)
            }
        }
        .sheet(isPresented: $viewModel.isExplorePresented) {
            ExploreRecipesView(viewModel: viewModel)
        }
    }
}

// MARK: - RecipesListView
private struct RecipesListView: View {
    @Environment(\.modelContext) private var modelContext
    var viewModel: RecipeBookViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeCard(recipe: recipe)
                    }
                }

                // Explore button at the bottom
                Button {
                    viewModel.isExplorePresented = true
                } label: {
                    HStack {
                        Image(systemName: "sparkles")
                        Text(String(localized: "recipebook.button.explore"))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .padding(.top, 8)
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - RecipeCard
struct RecipeCard: View {
    let recipe: Recipe

    /// Show at most 3 nutrient tags
    private var nutrientTags: [String] {
        Array(recipe.nutritionalStrategyTags.prefix(3))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }

            if !nutrientTags.isEmpty {
                HStack(spacing: 6) {
                    Text(String(localized: "recipebook.card.bestfor"))
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    ForEach(nutrientTags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.accentColor.opacity(0.12))
                            .foregroundStyle(Color.accentColor)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surface)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - PantryListView
private struct PantryListView: View {
    @Environment(\.modelContext) private var modelContext
    var viewModel: RecipeBookViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.pantryItems) { item in
                    HStack {
                        Image(systemName: item.isInStock ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(item.isInStock ? .green : .secondary)
                        Text(item.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(Color.surface)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .onTapGesture {
                        viewModel.togglePantryStatus(for: item, in: modelContext)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - ExploreRecipesView
struct ExploreRecipesView: View {
    var viewModel: RecipeBookViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.exploreRecipes) { recipe in
                            ExploreRecipeCard(recipe: recipe) {
                                viewModel.addToRecipeBook(recipe, context: modelContext)
                                dismiss()
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(String(localized: "recipebook.explore.text.title"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(String(localized: "recipebook.explore.button.done")) {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - ExploreRecipeCard
private struct ExploreRecipeCard: View {
    let recipe: Recipe
    let onAdd: () -> Void

    private var nutrientTags: [String] { Array(recipe.nutritionalStrategyTags.prefix(3)) }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(recipe.name)
                .font(.headline)
                .foregroundStyle(.primary)

            if !nutrientTags.isEmpty {
                HStack(spacing: 6) {
                    Text(String(localized: "recipebook.card.bestfor"))
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    ForEach(nutrientTags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.accentColor.opacity(0.12))
                            .foregroundStyle(Color.accentColor)
                            .clipShape(Capsule())
                    }
                }
            }

            Text("Yields \(recipe.yield) serving\(recipe.yield == 1 ? "" : "s")")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button(action: onAdd) {
                Label(String(localized: "recipebook.explore.button.add"), systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surface)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    RecipeBookView()
}
