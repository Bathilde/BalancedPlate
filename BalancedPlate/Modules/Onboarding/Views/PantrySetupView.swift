import SwiftUI

struct PantrySetupView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onNext: () -> Void
    
    let staples = ["Olive oil", "Salt", "Pepper", "Flour", "Sugar", "Rice"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.pantrysetup.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("onboarding.pantrysetup.text.subtitle")
                .foregroundColor(.secondary)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(staples, id: \.self) { staple in
                        Button {
                            viewModel.toggleStaple(staple)
                        } label: {
                            HStack {
                                Text(staple)
                                    .foregroundColor(.primary)
                                Spacer()
                                if viewModel.selectedStaples.contains(staple) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.surfaceColor)
                            .cornerRadius(12)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: onNext) {
                Text("onboarding.pantrysetup.button.next")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}
