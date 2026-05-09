import SwiftUI

struct ShoppingListView: View {
    var body: some View {
        NavigationView {
            Text("Shopping List Placeholder")
                .navigationTitle(String(localized: "shopping.main.text.title"))
        }
    }
}

#Preview {
    ShoppingListView()
}
