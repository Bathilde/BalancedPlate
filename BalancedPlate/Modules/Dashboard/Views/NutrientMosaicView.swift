import SwiftUI

struct NutrientMosaicView: View {
    let fills: [Nutrient: Double]
    let focus: [Nutrient]
    
    let columns = [
        GridItem(.adaptive(minimum: 80, maximum: 120), spacing: 12)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "dashboard.mosaic.text.title"))
                .font(.headline)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Nutrient.allCases, id: \.self) { nutrient in
                    MosaicTile(nutrient: nutrient, fill: fills[nutrient] ?? 0.0, isFocus: focus.contains(nutrient))
                }
            }
        }
        .padding()
        .cardStyle()
    }
}

struct MosaicTile: View {
    let nutrient: Nutrient
    let fill: Double
    let isFocus: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                // Background
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                
                // Fill
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorForNutrient(nutrient))
                    .frame(height: proxy.size.height * CGFloat(fill))
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: fill)
                
                // Label
                VStack {
                    Spacer()
                    Text(nutrient.rawValue.capitalized)
                        .font(isFocus ? .headline : .caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .padding(8)
                }
            }
        }
        .frame(height: isFocus ? 120 : 80)
    }
    
    private func colorForNutrient(_ nutrient: Nutrient) -> Color {
        switch nutrient {
        case .iron: return .red
        case .vitaminD: return .orange
        case .b12: return .purple
        case .calcium: return .gray
        case .magnesium: return .green
        case .zinc: return .blue
        case .vitaminC: return .yellow
        }
    }
}
