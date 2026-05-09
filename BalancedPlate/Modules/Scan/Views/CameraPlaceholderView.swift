import SwiftUI

struct CameraPlaceholderView: View {
    @Bindable var viewModel: ScanActionViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .aspectRatio(3/4, contentMode: .fit)
                    .cornerRadius(16)
                
                VStack {
                    Image(systemName: "viewfinder")
                        .font(.system(size: 64, weight: .ultraLight))
                        .foregroundColor(.white)
                    
                    Text("Point at an ingredient")
                        .foregroundColor(.white)
                        .padding(.top, 8)
                }
            }
            .padding()
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.analyzeCameraCapture()
                }
            } label: {
                Text(String(localized: "scan.input.button.capture"))
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal)
            
            Button {
                withAnimation {
                    viewModel.currentState = .manualEntry
                }
            } label: {
                Text(String(localized: "scan.input.button.manual"))
                    .foregroundColor(.accentColor)
                    .padding()
            }
        }
    }
}
