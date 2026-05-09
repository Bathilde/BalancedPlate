import SwiftUI

struct DailyLogView: View {
    let meals: [Meal]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "dashboard.dailylog.text.title"))
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if meals.isEmpty {
                        Text(String(localized: "dashboard.dailylog.text.empty"))
                            .foregroundColor(.secondary)
                            .padding()
                            .cardStyle()
                    } else {
                        ForEach(meals) { meal in
                            MealCard(meal: meal)
                        }
                    }
                }
                .padding(.horizontal)
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
        .background(Color.surfaceColor)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
