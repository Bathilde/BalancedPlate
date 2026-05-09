import SwiftUI

struct HealthFilterView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onNext: () -> Void
    
    let diets = ["No Restrictions", "Vegan", "Vegetarian", "Pescatarian"]
    let allergens = ["Nuts", "Dairy", "Gluten", "Shellfish"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.healthfilter.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("onboarding.healthfilter.text.subtitle")
                .foregroundColor(.secondary)
            
            Text("onboarding.healthfilter.text.diet")
                .font(.headline)
            
            Picker("Diet", selection: $viewModel.selectedDiet) {
                ForEach(diets, id: \.self) { diet in
                    Text(diet).tag(diet)
                }
            }
            .pickerStyle(.wheel)
            
            Text("onboarding.healthfilter.text.allergies")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(allergens, id: \.self) { allergy in
                    Button {
                        viewModel.toggleAllergy(allergy)
                    } label: {
                        Text(allergy)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.allergies.contains(allergy) ? Color.accentColor : Color.surface)
                            .foregroundColor(viewModel.allergies.contains(allergy) ? .white : .primary)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(Color.gray.opacity(0.3), lineWidth: viewModel.allergies.contains(allergy) ? 0 : 1)
                            )
                    }
                }
            }
            
            Spacer()
            
            Button(action: onNext) {
                Text("onboarding.healthfilter.button.next")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}
