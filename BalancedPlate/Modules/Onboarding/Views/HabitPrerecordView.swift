import SwiftUI

struct HabitPrerecordView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onNext: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("onboarding.habitprerecord.text.title")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("onboarding.habitprerecord.text.subtitle")
                .foregroundColor(.secondary)
            
            ScrollView {
                VStack(spacing: 16) {
                    let groupedHabits = Dictionary(grouping: viewModel.habits, by: { $0.type })
                    ForEach(groupedHabits.keys.sorted(), id: \.self) { type in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(type)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            ForEach(groupedHabits[type] ?? []) { habit in
                                Button {
                                    viewModel.toggleHabit(habit.id)
                                } label: {
                                    HStack {
                                        Text(habit.name)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if viewModel.selectedHabitIds.contains(habit.id) {
                                            Image(systemName: "checkmark.square.fill")
                                                .foregroundColor(.accentColor)
                                        } else {
                                            Image(systemName: "square")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(Color.surface)
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: onNext) {
                Text("onboarding.habitprerecord.button.next")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}
