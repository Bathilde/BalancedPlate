import SwiftUI

struct ManualEntryView: View {
    @Bindable var viewModel: ScanActionViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "keyboard")
                .font(.system(size: 64))
                .foregroundColor(.accentColor)
            
            Text("What do you want to cook with?")
                .font(.headline)
            
            TextField(String(localized: "scan.manual.text.placeholder"), text: $viewModel.manualText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button {
                Task {
                    await viewModel.analyzeManualEntry()
                }
            } label: {
                Text(String(localized: "scan.manual.button.analyze"))
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal)
            .disabled(viewModel.manualText.trimmingCharacters(in: .whitespaces).isEmpty)
            
            Spacer()
            
            Button {
                withAnimation {
                    viewModel.currentState = .input
                }
            } label: {
                Text("Cancel")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
