import SwiftUI

struct ShoppingListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ShoppingListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                
                VStack {
                    Picker("View Mode", selection: $viewModel.viewMode) {
                        Text(String(localized: "shopping.viewmode.global")).tag(ShoppingViewMode.global)
                        Text(String(localized: "shopping.viewmode.mealbymeal")).tag(ShoppingViewMode.mealByMeal)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if viewModel.viewMode == .global {
                        GlobalGroceryListView(viewModel: viewModel)
                    } else {
                        MealByMealGroceryListView(viewModel: viewModel)
                    }
                    
                    Button(action: {
                        // Scan ingredient action
                    }) {
                        Label("Scan Ingredient", systemImage: "barcode.viewfinder")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .padding()
                }
            }
            .navigationTitle(String(localized: "shopping.main.text.title"))

            .onAppear {
                viewModel.loadData(context: modelContext)
            }
        }
    }
}

#Preview {
    ShoppingListView()
}
