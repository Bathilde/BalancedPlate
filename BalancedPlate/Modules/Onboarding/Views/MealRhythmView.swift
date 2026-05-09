import SwiftUI

struct MealRhythmView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onNext: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.mealrhythm.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("onboarding.mealrhythm.text.subtitle")
                .foregroundColor(.secondary)
            
            VStack(spacing: 16) {
                HStack {
                    Text("onboarding.mealrhythm.text.breakfast")
                        .font(.headline)
                    Spacer()
                    DatePicker("", selection: $viewModel.breakfastTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .padding()
                .background(Color.surfaceColor)
                .cornerRadius(12)
                
                HStack {
                    Text("onboarding.mealrhythm.text.lunch")
                        .font(.headline)
                    Spacer()
                    DatePicker("", selection: $viewModel.lunchTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .padding()
                .background(Color.surfaceColor)
                .cornerRadius(12)
                
                HStack {
                    Text("onboarding.mealrhythm.text.dinner")
                        .font(.headline)
                    Spacer()
                    DatePicker("", selection: $viewModel.dinnerTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .padding()
                .background(Color.surfaceColor)
                .cornerRadius(12)
            }
            .padding(.vertical)
            
            Spacer()
            
            Button(action: onNext) {
                Text("onboarding.mealrhythm.button.next")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}
