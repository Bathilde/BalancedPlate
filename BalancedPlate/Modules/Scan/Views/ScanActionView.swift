import SwiftUI

struct ScanActionView: View {
    @State private var viewModel = ScanActionViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                
                switch viewModel.currentState {
                case .input:
                    CameraPlaceholderView(viewModel: viewModel)
                case .manualEntry:
                    ManualEntryView(viewModel: viewModel)
                case .analyzing:
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Analyzing...")
                            .padding(.top)
                            .foregroundColor(.secondary)
                    }
                case .results:
                    ScanResultsView(viewModel: viewModel)
                }
            }
            .navigationTitle(String(localized: "scan.main.text.title"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScanActionView()
}
