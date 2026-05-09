import SwiftUI

struct HouseholdSizeView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onNext: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.householdsize.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("onboarding.householdsize.text.subtitle")
                .foregroundColor(.secondary)
            
            Spacer()
            
            VStack(spacing: 32) {
                Text("\(viewModel.householdSize)")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.accentColor)
                
                Stepper(value: $viewModel.householdSize, in: 1...10) {
                    Text("onboarding.householdsize.text.people")
                        .font(.title2)
                }
                .padding()
                .background(Color.surfaceColor)
                .cornerRadius(16)
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            Button(action: onNext) {
                Text("onboarding.householdsize.button.next")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}
