import SwiftUI

struct OnboardingRootView: View {
    @State private var viewModel = OnboardingViewModel()
    @State private var currentStep = 0
    
    var body: some View {
        TabView(selection: $currentStep) {
            HealthFilterView(viewModel: viewModel) {
                withAnimation { currentStep = 1 }
            }
            .tag(0)
            
            GoalSetterView(viewModel: viewModel) {
                withAnimation { currentStep = 2 }
            }
            .tag(1)
            
            PantrySetupView(viewModel: viewModel) {
                withAnimation { currentStep = 3 }
            }
            .tag(2)
            
            HabitPrerecordView(viewModel: viewModel) {
                withAnimation { currentStep = 4 }
            }
            .tag(3)
            
            HouseholdSizeView(viewModel: viewModel) {
                withAnimation { currentStep = 5 }
            }
            .tag(4)
            
            MealRhythmView(viewModel: viewModel) {
                withAnimation { currentStep = 6 }
            }
            .tag(5)
            
            SuccessRevealView(viewModel: viewModel) {
                // Done - the ContentView will react to the UserSetting being saved
            }
            .tag(6)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    OnboardingRootView()
        .modelContainer(for: [UserSetting.self, Meal.self, Recipe.self, Ingredient.self, PantryItem.self], inMemory: true)
}
