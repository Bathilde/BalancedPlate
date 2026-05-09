# The Balanced Plate: App Concept Specification

A nutrition-focused app designed to address vitamin deficiencies through food variety and seasonal eating, without the friction of calorie counting or gram-based tracking.

## 1. Core Philosophy: Diversity over Density
Most nutrition apps fail by demanding "laboratory precision" (weighing food in grams). This app assumes that:
* **Variety creates coverage:** If you eat a wide spectrum of colors and food groups, deficiencies naturally resolve.
* **Context matters:** Nutrients degrade based on freshness and cooking methods (e.g., Vitamin C oxidation).
* **Flexibility is key:** The app should feel like a "culinary coach" rather than a "medical monitor."

---

## 2. Feature Specification

### A. The "Visual Narrative" (Tracking)
Instead of manual data entry, the app uses computer vision to log food qualitatively.
* **Image Recognition:** Snap a photo of your plate. The AI identifies core ingredients (e.g., "Salmon, Spinach, Lemon, Walnuts").
* **The "Freshness & Prep" Toggle:** A quick post-photo selection to account for nutrient degradation:
    * *Raw/Freshly Cut* (High Vitamin Retention)
    * *Cooked/Steamed* (Moderate Retention)
    * *Processed/Pre-packaged* (Low Retention)
* **Diversity Score:** A visual dashboard (e.g., a "Rainbow Wheel") showing which food groups or micronutrient categories (B-Vitamins, Fat-Soluble Vitamins, Minerals) have been covered over the last 7 days. Fueled by **SwiftData** with optional HealthKit syncing.

### B. The "Recipe Engine" & Shopping Loop
* **Meal-to-Recipe Promotion:** Users can save a logged meal as a reusable "Recipe" with a custom name and yield (servings).
* **Nutritional Strategy:** The shopping list is fueled by selected recipes plus "Gap Filler" suggestions.
* **Dynamic Scaling:** Ingredient quantities in the shopping list scale based on `HouseholdSize` and `ShoppingInterval`.

| Entity | Role | Persistence |
| :--- | :--- | :--- |
| **Recipe** | A template of ingredients + preparation style. | **SwiftData** |
| **ShoppingItem** | An ingredient linked to a Recipe, flagged as "To Buy." | **SwiftData** |
| **Meal** | A historical log of a Recipe or custom entry. | **SwiftData** |

### C. The "Store-Side" Assistant
* **Scan-to-Recipe:** Snapshot a vegetable in-store (e.g., Romanesco) to trigger recipe ideas that fill your current nutritional gaps.

---

## 3. Configuration & Personalization
* **Deficiency Focus:** Users toggle specific vitamins/minerals (e.g., Iron, Vitamin D, B12).
* **Allergies & Tastes:** Strict exclusion of allergens and a "like/dislike" weighting.

---

## 4. Technical Considerations (The "Precision" Logic)
The app uses a **Coefficient of Loss** model ($L$):
* **Base Value ($V_b$):** Sourced from Nutrition NLP APIs using "average household sizes" (e.g., "1 medium bell pepper").
* **Final Value ($V_f$):** Calculated as $V_f = V_b 	imes L_{prep} 	imes L_{time}$
    * $L_{prep}$: Cooking method (Steamed: 0.9, Boiled: 0.6).
    * $L_{time}$: Time since prep (Fresh: 1.0, 1h+ Pre-cut: 0.7).

---

## 5. iOS System Architecture & Data Flow (Dual-Storage Model)

### 1. Input Layer (The "What")
* **Vision:** `Vision Framework` + `CoreML` identifies objects.
* **NLP Processing:** Identified strings are sent to the **Edamam Nutrition Analysis API**. 
    * *Why:* Converts "Natural Language" to nutrient JSON without requiring gram inputs.

### 2. Logic Layer (The "How")
* **Nutrient Adjustment:** A custom Swift service applies the "Coefficient of Loss" logic to the JSON response.
* **Local Persistence (SwiftData):** The primary save. All meals, recipes, and adjusted nutrients are stored in the app's private SQLite database.
* **HealthKit Integration (Optional):** If authorized, the app mirrors the data to `HKHealthStore`.

### 3. Intelligence Layer (The "Why")
* **Gap Analysis:** The app queries **SwiftData** for the last 7 days of logs to calculate the "Diversity Score."
* **Recommendation:** If a deficiency is detected, the app triggers a `GET` request to the **Spoonacular API** for "Bridge Meals."

| Component | Technology | Role |
| :--- | :--- | :--- |
| **API** | Edamam / Nutritionix | Converts "1 Apple" to nutrient JSON. |
| **Primary Storage** | **SwiftData** | Local "Source of Truth" for logs, recipes, and lists. |
| **Search** | Spoonacular API | Finds recipes based on missing micronutrients. |
| **Location** | CoreLocation | Determines seasonality for the store assistant. |

---

## 6. Data Model (SwiftData Schema)
* **Recipe Model:** Name, Servings, `[Ingredient]`, `NutrientProfile`.
* **Meal Model:** Date, `Recipe` (optional), `[Ingredient]` (if custom), PhotoData.
* **ShoppingList Model:** `[ShoppingItem]`, IsCompleted (Bool).
* **Ingredient Model:** Name, QuantityDescriptor, Nutrient Metadata.

---

## 7. Version History
* **v1.0.0:** Initial concept.
* **v1.1.0:** Added iOS Technical Flow, HealthKit integration, and NLP logic for gram-free tracking.
* **v1.2.0:** Updated architecture to a Dual-Storage model using **SwiftData** as the primary persistence layer.
* **v1.3.0:** Added Recipe Engine and Meal-driven Shopping List integration.
