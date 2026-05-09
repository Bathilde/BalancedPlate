import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userSettings: [UserSetting]

    var body: some View {
        if userSettings.isEmpty {
            OnboardingPlaceholderView()
        } else {
            MainTabView()
        }
    }
}

struct OnboardingPlaceholderView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 24) {
            Text(String(localized: "onboarding.welcome.text.title"))
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button {
                let initialSetting = UserSetting()
                modelContext.insert(initialSetting)
            } label: {
                Text(String(localized: "onboarding.welcome.button.start"))
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primaryBackground)
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            Text(String(localized: "dashboard.main.text.title"))
                .tabItem {
                    Label("Dashboard", systemImage: "chart.pie.fill")
                }
            
            Text("Library")
                .tabItem {
                    Label("Library", systemImage: "books.vertical.fill")
                }
            
            Text("Scan")
                .tabItem {
                    Label("Scan", systemImage: "camera.viewfinder")
                }
            
            Text("Shopping List")
                .tabItem {
                    Label("Shopping", systemImage: "cart.fill")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserSetting.self, Meal.self, Recipe.self, Ingredient.self, PantryItem.self], inMemory: true)
}
