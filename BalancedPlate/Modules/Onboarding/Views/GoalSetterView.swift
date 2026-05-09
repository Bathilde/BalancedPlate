import SwiftUI

struct GoalSetterView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onNext: () -> Void
    
    let symptoms: [Symptom] = [.lackOfEnergy, .boneHealth, .anemia, .poorImmunity]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.goalsetter.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("onboarding.goalsetter.text.subtitle")
                .foregroundColor(.secondary)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(symptoms, id: \.self) { symptom in
                        Button {
                            viewModel.toggleSymptom(symptom)
                        } label: {
                            VStack {
                                Image(systemName: iconForSymptom(symptom))
                                    .font(.title)
                                    .padding(.bottom, 8)
                                Text(titleForSymptom(symptom))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .background(viewModel.selectedSymptoms.contains(symptom) ? Color.accentColor.opacity(0.2) : Color.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(viewModel.selectedSymptoms.contains(symptom) ? Color.accentColor : Color.gray.opacity(0.2), lineWidth: 2)
                            )
                            .cornerRadius(16)
                            .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.vertical)
            }
            
            Spacer()
            
            Button(action: onNext) {
                Text("onboarding.goalsetter.button.next")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
    }
    
    private func iconForSymptom(_ symptom: Symptom) -> String {
        switch symptom {
        case .lackOfEnergy: return "bolt.batteryblock"
        case .boneHealth: return "figure.walk"
        case .anemia: return "drop.fill"
        case .poorImmunity: return "shield.fill"
        }
    }
    
    private func titleForSymptom(_ symptom: Symptom) -> String {
        switch symptom {
        case .lackOfEnergy: return String(localized: "onboarding.goalsetter.text.lackofenergy")
        case .boneHealth: return String(localized: "onboarding.goalsetter.text.bonehealth")
        case .anemia: return String(localized: "onboarding.goalsetter.text.anemia")
        case .poorImmunity: return String(localized: "onboarding.goalsetter.text.poorimmunity")
        }
    }
}
