import SwiftUI

struct DailyLogView: View {
    let mealsByType: [MealType: [Meal]]
    let currentMealType: MealType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(String(localized: "dashboard.dailylog.text.title"))
                .font(.headline)
                .padding(.horizontal)
            
            ForEach([MealType.breakfast, .lunch, .dinner], id: \.self) { mealType in
                MealTypeSection(
                    title: mealType.rawValue.capitalized,
                    meals: mealsByType[mealType] ?? [],
                    isCurrentMeal: mealType == currentMealType
                )
            }
        }
    }
}

struct MealTypeSection: View {
    let title: String
    let meals: [Meal]
    let isCurrentMeal: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                if isCurrentMeal {
                    Text("Current")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.accentColor.opacity(0.2))
                        .foregroundColor(.accentColor)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            
            if !meals.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(meals) { meal in
                            MealCard(meal: meal)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("No meals logged")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            
            if isCurrentMeal {
                HStack(spacing: 12) {
                    Button(action: {
                        // Scan action
                    }) {
                        Label("Scan Meal", systemImage: "camera.viewfinder")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    
                    Button(action: {
                        // Add manually
                    }) {
                        Label("Add Manually", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                .padding(.top, 4)
            }
        }
    }
}

struct MealCard: View {
    let meal: Meal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(meal.timestamp, style: .time)
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let firstIngredient = meal.ingredients.first {
                Text(firstIngredient.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
            } else {
                Text("Unknown Meal")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            Text("\(meal.ingredients.count) ingredients")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 140, alignment: .leading)
        .background(Color.surface)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
