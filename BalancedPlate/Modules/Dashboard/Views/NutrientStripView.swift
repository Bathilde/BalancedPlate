import SwiftUI

// MARK: - NutrientStripView
/// Compact horizontal strip showing only the user's favorited nutrients,
/// with a chevron that opens the full NutrientDetailView sheet.
struct NutrientStripView: View {
    let fills: [Nutrient: Double]
    @Binding var favorites: [Nutrient]
    
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "dashboard.nutrients.text.title"))
                .font(.headline)
            
            HStack(spacing: 12) {
                if favorites.isEmpty {
                    Text(String(localized: "dashboard.nutrients.text.empty"))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(favorites, id: \.self) { nutrient in
                                NutrientBar(
                                    nutrient: nutrient,
                                    fill: fills[nutrient] ?? 0
                                )
                            }
                        }
                    }
                }
                
                Button {
                    showDetail = true
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                .accessibilityLabel(Text("View all nutrients"))
            }
        }
        .padding()
        .cardStyle()
        .sheet(isPresented: $showDetail) {
            NutrientDetailView(fills: fills, favorites: $favorites)
        }
    }
}

// MARK: - NutrientBar
struct NutrientBar: View {
    let nutrient: Nutrient
    let fill: Double
    
    private var color: Color { colorForNutrient(nutrient) }
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 60)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 44, height: 60 * CGFloat(fill))
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: fill)
            }
            
            Text(nutrient.displayName)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(color)
                .lineLimit(1)
        }
        .frame(width: 44)
    }
    
    private func colorForNutrient(_ n: Nutrient) -> Color {
        switch n {
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

// MARK: - NutrientDetailView
struct NutrientDetailView: View {
    let fills: [Nutrient: Double]
    @Binding var favorites: [Nutrient]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(Nutrient.allCases, id: \.self) { nutrient in
                        NutrientDetailRow(
                            nutrient: nutrient,
                            fill: fills[nutrient] ?? 0,
                            isFavorite: favorites.contains(nutrient)
                        ) {
                            toggleFavorite(nutrient)
                        }
                    }
                }
                .padding()
            }
            .background(Color.primaryBackground.ignoresSafeArea())
            .navigationTitle(String(localized: "nutrientdetail.main.text.title"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(String(localized: "nutrientdetail.button.done")) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func toggleFavorite(_ nutrient: Nutrient) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            if let idx = favorites.firstIndex(of: nutrient) {
                favorites.remove(at: idx)
            } else {
                favorites.append(nutrient)
            }
        }
    }
}

// MARK: - NutrientDetailRow
struct NutrientDetailRow: View {
    let nutrient: Nutrient
    let fill: Double
    let isFavorite: Bool
    let onToggle: () -> Void
    
    private var fillPercent: Int { Int(fill * 100) }
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(colorForNutrient(nutrient))
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(nutrient.displayName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(colorForNutrient(nutrient).opacity(0.15))
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(colorForNutrient(nutrient))
                            .frame(width: geo.size.width * CGFloat(fill))
                            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: fill)
                    }
                }
                .frame(height: 6)
            }
            
            Text("\(fillPercent)%")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 36, alignment: .trailing)
            
            Button(action: onToggle) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundStyle(isFavorite ? .yellow : .secondary)
                    .font(.title3)
                    .contentTransition(.symbolEffect(.replace))
            }
        }
        .padding()
        .background(Color.surface)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
    
    private func colorForNutrient(_ n: Nutrient) -> Color {
        switch n {
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
