import SwiftUI
import SwiftData

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var userSettings: [UserSetting]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    if let setting = userSettings.first {
                        NutrientMosaicView(fills: viewModel.mosaicFills, focus: setting.deficiencyFocus)
                    } else {
                        NutrientMosaicView(fills: viewModel.mosaicFills, focus: [])
                    }
                    
                    DailyLogView(meals: viewModel.loggedMeals)
                    
                    RecommendationEngineView(isScarcityMode: viewModel.isScarcityMode, bridgeMeals: viewModel.bridgeMeals)
                }
                .padding(.vertical)
            }
            .background(Color.primaryBackground.ignoresSafeArea())
            .navigationTitle(String(localized: "dashboard.main.text.title"))
            .task {
                if let setting = userSettings.first {
                    await viewModel.loadDashboardData(context: modelContext, userSettings: setting)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: [UserSetting.self, Meal.self, Recipe.self, Ingredient.self, PantryItem.self], inMemory: true)
}
