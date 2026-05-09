import SwiftUI

struct GlobalGroceryListView: View {
    @Bindable var viewModel: ShoppingListViewModel
    
    var body: some View {
        let items = viewModel.consolidatedIngredients
        
        if items.isEmpty {
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "cart.badge.minus")
                    .font(.system(size: 64))
                    .foregroundColor(.gray)
                Text(String(localized: "shopping.empty.text"))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Spacer()
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(items) { item in
                        let isChecked = viewModel.checkedIngredients.contains(item.id)
                        
                        Button {
                            withAnimation {
                                viewModel.toggleCheck(for: item.id)
                            }
                        } label: {
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                    .strikethrough(isChecked, color: .secondary)
                                    .foregroundColor(isChecked ? .secondary : .primary)
                                
                                Spacer()
                                
                                Text("\(item.totalAmount, specifier: "%.1f") \(item.unit)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isChecked ? .accentColor : .gray)
                                    .padding(.leading, 8)
                            }
                            .padding()
                            .background(Color.surfaceColor)
                            .cornerRadius(12)
                            .opacity(isChecked ? 0.6 : 1.0)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
