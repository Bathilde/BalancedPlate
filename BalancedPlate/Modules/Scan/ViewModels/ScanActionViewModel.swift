import Foundation
import Observation

enum ScanState {
    case input
    case manualEntry
    case analyzing
    case results
}

@Observable
final class ScanActionViewModel {
    var currentState: ScanState = .input
    var manualText: String = ""
    
    var identifiedIngredientName: String?
    var suggestedRecipes: [Recipe] = []
    
    let nutritionService: NutritionServiceProtocol
    
    init(nutritionService: NutritionServiceProtocol = MockNutritionService()) {
        self.nutritionService = nutritionService
    }
    
    func analyzeCameraCapture() async {
        currentState = .analyzing
        
        // Mock a 2 second network/vision delay
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let ingredient = "Romanesco Broccoli"
        identifiedIngredientName = ingredient
        
        do {
            suggestedRecipes = try await nutritionService.getRecipes(for: ingredient)
            currentState = .results
        } catch {
            // Fallback to error handling in a real app
            currentState = .input
        }
    }
    
    func analyzeManualEntry() async {
        guard !manualText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        currentState = .analyzing
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        identifiedIngredientName = manualText
        
        do {
            suggestedRecipes = try await nutritionService.getRecipes(for: manualText)
            currentState = .results
        } catch {
            currentState = .manualEntry
        }
    }
    
    func reset() {
        manualText = ""
        identifiedIngredientName = nil
        suggestedRecipes = []
        currentState = .input
    }
}
