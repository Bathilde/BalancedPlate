import SwiftUI

struct RecommendationEngineView: View {
    let isScarcityMode: Bool
    let bridgeMeals: [Recipe]
    
    var body: some View {
        VStack(alignment: .leading) {
            if isScarcityMode {
                Text(String(localized: "dashboard.recommendation.text.scarcity_title"))
                    .font(.headline)
                
                Text(String(localized: "dashboard.recommendation.text.scarcity_subtitle"))
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding(.bottom, 8)
                
                Button {
                    // Action to log staples
                } label: {
                    Text(String(localized: "dashboard.recommendation.button.log_staples"))
                }
                .buttonStyle(SecondaryButtonStyle())
                
            } else {
                Text(String(localized: "dashboard.recommendation.text.rich_title"))
                    .font(.headline)
                
                ForEach(bridgeMeals) { recipe in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        HStack {
                            ForEach(recipe.nutritionalStrategyTags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.accentColor.opacity(0.2))
                                    .foregroundColor(.accentColor)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.surface)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
            }
        }
        .padding()
        .cardStyle()
    }
}
