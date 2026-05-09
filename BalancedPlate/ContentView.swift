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
            
            LibraryView()
                .tabItem {
                    Label(String(localized: "library.main.text.title"), systemImage: "books.vertical.fill")
                }
            
            ScanActionView()
                .tabItem {
                    Label(String(localized: "scan.main.text.title"), systemImage: "camera.viewfinder")
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
