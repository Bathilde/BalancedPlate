import SwiftUI

struct LibraryView: View {
    var body: some View {
        NavigationView {
            Text("Library Placeholder")
                .navigationTitle(String(localized: "library.main.text.title"))
        }
    }
}

#Preview {
    LibraryView()
}
