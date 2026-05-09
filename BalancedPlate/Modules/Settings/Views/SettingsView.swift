import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(String(localized: "settings.section.preferences"))) {
                    Picker(String(localized: "settings.unitsystem"), selection: $viewModel.unitSystem) {
                        Text("Metric").tag(UnitSystem.metric)
                        Text("US Imperial").tag(UnitSystem.imperialUS)
                        Text("UK Imperial").tag(UnitSystem.imperialUK)
                    }
                    .onChange(of: viewModel.unitSystem) { _, _ in
                        viewModel.saveSettings(context: modelContext)
                    }
                    
                    Stepper(value: $viewModel.householdSize, in: 1...20) {
                        HStack {
                            Text(String(localized: "settings.householdsize"))
                            Spacer()
                            Text("\(viewModel.householdSize)")
                                .foregroundColor(.secondary)
                        }
                    }
                    .onChange(of: viewModel.householdSize) { _, _ in
                        viewModel.saveSettings(context: modelContext)
                    }
                }
                
                if let setting = viewModel.userSetting {
                    Section(header: Text("Health Profile")) {
                        NavigationLink(destination: Text("Deficiency Focus Picker Placeholder")) {
                            HStack {
                                Text("Deficiency Focus")
                                Spacer()
                                Text("\(setting.deficiencyFocus.count) selected")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(String(localized: "settings.main.text.title"))
            .onAppear {
                viewModel.loadData(context: modelContext)
            }
        }
    }
}

#Preview {
    SettingsView()
}
