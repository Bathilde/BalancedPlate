import Foundation
import SwiftData

// MARK: - Enums
enum UnitSystem: String, Codable {
    case metric
    case imperialUS
    case imperialUK
}

enum Nutrient: String, Codable {
    case iron
    case vitaminD
    case b12
    case calcium
    case magnesium
    case zinc
    case vitaminC
}

enum Symptom: String, Codable {
    case lackOfEnergy
    case boneHealth
    case anemia
    case poorImmunity
}

// MARK: - Models

@Model
final class UserSetting {
    var preferredUnitSystemRaw: String = UnitSystem.metric.rawValue
    var householdSize: Int = 1
    var deficiencyFocusRaw: [String] = []
    var symptomsRaw: [String] = []
    
    var preferredUnitSystem: UnitSystem {
        get { UnitSystem(rawValue: preferredUnitSystemRaw) ?? .metric }
        set { preferredUnitSystemRaw = newValue.rawValue }
    }
    
    var deficiencyFocus: [Nutrient] {
        get { deficiencyFocusRaw.compactMap { Nutrient(rawValue: $0) } }
        set { deficiencyFocusRaw = newValue.map { $0.rawValue } }
    }
    
    var symptoms: [Symptom] {
        get { symptomsRaw.compactMap { Symptom(rawValue: $0) } }
        set { symptomsRaw = newValue.map { $0.rawValue } }
    }
    
    init(preferredUnitSystem: UnitSystem = .metric, householdSize: Int = 1, deficiencyFocus: [Nutrient] = [], symptoms: [Symptom] = []) {
        self.preferredUnitSystemRaw = preferredUnitSystem.rawValue
        self.householdSize = householdSize
        self.deficiencyFocusRaw = deficiencyFocus.map { $0.rawValue }
        self.symptomsRaw = symptoms.map { $0.rawValue }
    }
}

@Model
final class Ingredient {
    var name: String
    var rawInputUnit: String
    var standardizedWeightGrams: Double
    var displayAmount: Double
    var displayUnit: String
    
    @Relationship(inverse: \Meal.ingredients) var meals: [Meal]?
    @Relationship(inverse: \Recipe.ingredients) var recipes: [Recipe]?
    
    init(name: String, rawInputUnit: String, standardizedWeightGrams: Double, displayAmount: Double, displayUnit: String) {
        self.name = name
        self.rawInputUnit = rawInputUnit
        self.standardizedWeightGrams = standardizedWeightGrams
        self.displayAmount = displayAmount
        self.displayUnit = displayUnit
    }
}

@Model
final class Meal {
    var timestamp: Date
    var isFavorite: Bool
    var photoData: Data?
    var ingredients: [Ingredient]
    
    init(timestamp: Date = Date(), isFavorite: Bool = false, photoData: Data? = nil, ingredients: [Ingredient] = []) {
        self.timestamp = timestamp
        self.isFavorite = isFavorite
        self.photoData = photoData
        self.ingredients = ingredients
    }
}

@Model
final class Recipe {
    var name: String
    var yield: Int
    var nutritionalStrategyTags: [String]
    var ingredients: [Ingredient]
    
    init(name: String, yield: Int = 1, nutritionalStrategyTags: [String] = [], ingredients: [Ingredient] = []) {
        self.name = name
        self.yield = yield
        self.nutritionalStrategyTags = nutritionalStrategyTags
        self.ingredients = ingredients
    }
}

@Model
final class PantryItem {
    var name: String
    var isStaple: Bool
    var isInStock: Bool
    var lastUpdated: Date
    
    init(name: String, isStaple: Bool = false, isInStock: Bool = true, lastUpdated: Date = Date()) {
        self.name = name
        self.isStaple = isStaple
        self.isInStock = isInStock
        self.lastUpdated = lastUpdated
    }
}
