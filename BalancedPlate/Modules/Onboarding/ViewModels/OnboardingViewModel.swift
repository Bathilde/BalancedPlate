import Foundation
import Observation

@Observable
final class OnboardingViewModel {
    // Step 1: Health Filter
    var selectedDiet: String = "No Restrictions"
    var allergies: Set<String> = []
    
    // Step 2: Goal Setter
    var selectedSymptoms: Set<Symptom> = []
    
    // Step 3: Pantry Setup
    var selectedStaples: Set<String> = []
    
    // Step 4: Habit Prerecord
    var selectedHabitIds: Set<String> = []
    var habits: [HabitTemplate] = []
    
    // Step 5: Household Size
    var householdSize: Int = 1
    
    // Step 6: Meal Rhythm
    var breakfastTime: Date = defaultTime(hour: 8)
    var lunchTime: Date = defaultTime(hour: 12)
    var dinnerTime: Date = defaultTime(hour: 19)
    
    // Step 7: Success Reveal
    var bridgeMeal: Recipe?
    var isLoadingMeal: Bool = false
    
    let nutritionService: NutritionServiceProtocol
    
    init(nutritionService: NutritionServiceProtocol = MockNutritionService()) {
        self.nutritionService = nutritionService
        loadHabits()
    }
    
    func loadHabits() {
        guard let url = Bundle.main.url(forResource: "habits", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([HabitTemplate].self, from: data) else {
            return
        }
        self.habits = decoded
    }
    
    func toggleAllergy(_ allergy: String) {
        if allergies.contains(allergy) {
            allergies.remove(allergy)
        } else {
            allergies.insert(allergy)
        }
    }
    
    func toggleSymptom(_ symptom: Symptom) {
        if selectedSymptoms.contains(symptom) {
            selectedSymptoms.remove(symptom)
        } else {
            selectedSymptoms.insert(symptom)
        }
    }
    
    func toggleStaple(_ staple: String) {
        if selectedStaples.contains(staple) {
            selectedStaples.remove(staple)
        } else {
            selectedStaples.insert(staple)
        }
    }
    
    func toggleHabit(_ habitId: String) {
        if selectedHabitIds.contains(habitId) {
            selectedHabitIds.remove(habitId)
        } else {
            selectedHabitIds.insert(habitId)
        }
    }
    
    func fetchBridgeMeal() async {
        isLoadingMeal = true
        defer { isLoadingMeal = false }
        
        let focus = Array(selectedSymptoms).flatMap { symptom -> [Nutrient] in
            switch symptom {
            case .lackOfEnergy: return [.b12, .iron]
            case .boneHealth: return [.calcium, .vitaminD]
            case .anemia: return [.iron]
            case .poorImmunity: return [.zinc, .vitaminC]
            }
        }
        
        do {
            let meals = try await nutritionService.getBridgeMeals(deficiencyFocus: Array(Set(focus)))
            bridgeMeal = meals.first
        } catch {
            print("Failed to fetch bridge meal")
        }
    }
    
    private static func defaultTime(hour: Int) -> Date {
        var components = DateComponents()
        components.hour = hour
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct HabitTemplate: Codable, Identifiable {
    let id: String
    let name: String
    let type: String
}
