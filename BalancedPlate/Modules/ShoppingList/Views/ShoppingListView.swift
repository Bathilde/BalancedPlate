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
                }
            }
            .navigationTitle(String(localized: "shopping.main.text.title"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.hidePantryItems.toggle()
                    } label: {
                        Image(systemName: viewModel.hidePantryItems ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .onAppear {
                viewModel.loadData(context: modelContext)
            }
        }
    }
}

#Preview {
    ShoppingListView()
}
