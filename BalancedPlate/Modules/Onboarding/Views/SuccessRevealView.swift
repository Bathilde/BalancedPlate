import SwiftUI
import SwiftData

struct SuccessRevealView: View {
    @Bindable var viewModel: OnboardingViewModel
    @Environment(\.modelContext) private var modelContext
    let onFinish: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.successreveal.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if viewModel.isLoadingMeal {
                Spacer()
                ProgressView()
                    .frame(maxWidth: .infinity)
                Spacer()
            } else if let bridgeMeal = viewModel.bridgeMeal {
                Text("onboarding.successreveal.text.subtitle")
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(bridgeMeal.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("onboarding.successreveal.text.ingredients")
                        .font(.headline)
                    
                    ForEach(bridgeMeal.ingredients) { ingredient in
                        Text("• \(Int(ingredient.displayAmount)) \(ingredient.displayUnit) \(ingredient.name)")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.surfaceColor)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                
                Spacer()
            } else {
                Spacer()
                Text("onboarding.successreveal.text.error")
                    .foregroundColor(.red)
                Spacer()
            }
            
            Button {
                saveUserSetting()
                onFinish()
            } label: {
                Text("onboarding.successreveal.button.finish")
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(viewModel.isLoadingMeal)
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
        .task {
            await viewModel.fetchBridgeMeal()
        }
    }
    
    private func saveUserSetting() {
        let setting = UserSetting(
            preferredUnitSystem: .metric, // default
            householdSize: viewModel.householdSize,
            deficiencyFocus: Array(viewModel.selectedSymptoms).flatMap {
                switch $0 {
                case .lackOfEnergy: return [.b12, .iron]
                case .boneHealth: return [.calcium, .vitaminD]
                case .anemia: return [.iron]
                case .poorImmunity: return [.zinc, .vitaminC]
                }
            },
            symptoms: Array(viewModel.selectedSymptoms)
        )
        modelContext.insert(setting)
    }
}
