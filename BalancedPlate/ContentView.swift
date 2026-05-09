import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userSettings: [UserSetting]

    var body: some View {
        if userSettings.isEmpty {
            OnboardingRootView()
        } else {
            MainTabView()
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label(String(localized: "dashboard.main.text.title"), systemImage: "chart.pie.fill")
                }
            
            RecipeBookView()
                .tabItem {
                    Label(String(localized: "recipebook.main.text.title"), systemImage: "book.closed.fill")
                }
            

            ShoppingListView()
                .tabItem {
                    Label(String(localized: "shopping.main.text.title"), systemImage: "cart.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label(String(localized: "settings.main.text.title"), systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserSetting.self, Meal.self, Recipe.self, Ingredient.self, PantryItem.self], inMemory: true)
}
