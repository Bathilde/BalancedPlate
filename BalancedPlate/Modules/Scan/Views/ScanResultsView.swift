import SwiftUI

struct ScanResultsView: View {
    @Bindable var viewModel: ScanActionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(String(format: String(localized: "scan.results.text.identified"), viewModel.identifiedIngredientName ?? "Unknown"))
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    withAnimation {
                        viewModel.reset()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            Text(String(localized: "scan.results.text.recipes"))
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.suggestedRecipes) { recipe in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(recipe.name)
                                .font(.headline)
                            
                            HStack {
                                ForEach(recipe.nutritionalStrategyTags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.accentColor.opacity(0.2))
                                        .foregroundColor(.accentColor)
                                        .clipShape(Capsule())
                                }
                            }
                            
                            Text("\(recipe.ingredients.count) ingredients • Yields \(recipe.yield)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.surfaceColor)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}
