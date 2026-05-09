import SwiftUI

struct LibraryView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                
                VStack {
                    Picker("View Mode", selection: $viewModel.viewMode) {
                        Text(String(localized: "library.picker.recipes")).tag(LibraryViewMode.recipes)
                        Text(String(localized: "library.picker.pantry")).tag(LibraryViewMode.pantry)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if viewModel.viewMode == .recipes {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.recipes) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        HStack {
                                            Text(recipe.name)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.secondary)
                                        }
                                        .padding()
                                        .background(Color.surfaceColor)
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.pantryItems) { item in
                                    HStack {
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.surfaceColor)
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle(String(localized: "library.main.text.title"))
            .onAppear {
                viewModel.loadData(context: modelContext)
            }
        }
    }
}

#Preview {
    LibraryView()
}
