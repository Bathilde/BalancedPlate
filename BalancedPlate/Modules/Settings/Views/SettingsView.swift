import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Text("Settings Placeholder")
                .navigationTitle(String(localized: "settings.main.text.title"))
        }
    }
}

#Preview {
    SettingsView()
}
