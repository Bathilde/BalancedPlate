# The Balanced Plate: App Concept Specification

A nutrition-focused app designed to address vitamin deficiencies through food variety and seasonal eating, without the friction of calorie counting or gram-based tracking.

## 1. Core Philosophy: Diversity over Density
Most nutrition apps fail by demanding "laboratory precision" (weighing food in grams). This app assumes that:
* **Variety creates coverage:** If you eat a wide spectrum of colors and food groups, deficiencies naturally resolve.
* **Flexibility is key:** The app should feel like a "culinary coach" rather than a "medical monitor."
* **Variety creates coverage:** Focus on food groups and colors rather than grams.
* **Low Operational Cost:** Minimal API surface (Edamam/Spoonacular) with aggressive local caching.
* **Adaptive Coaching:** A UI that scales its complexity based on the volume of data provided.

---

## 2. Feature Specification

### A. Nutrient Assistance (The Dashboard)
The primary entry point, providing immediate feedback and planning.
* **The "Rainbow Wheel":** Visual representation of micronutrient coverage over a rolling 7-day window.
* **Daily Log View:** A scrollable list of the **Current Day's Meals** for quick review, editing, or "Save as Recipe" promotion.
* **Conditional Recommendation Engine (72h Window):**
    * **Data Scarcity (< 5 meals logged):** Displays "Fuel Your Wheel"—a list of favorite ingredients or high-density staples to encourage logging.
    * **Data Rich (≥ 5 meals logged):** Displays "Bridge Meals"—3 specific Spoonacular recipes that fill the identified nutrient gaps.
    * **Action:** One-tap "Add to Shopping List" for any recommended meal.

### B. The "Recipe Engine" & Shopping Loop
* **Meal-to-Recipe Promotion:** Users can save any logged meal as a reusable "Recipe" with a custom name and yield (servings).
* **Nutritional Strategy:** The shopping list is fueled by selected recipes plus "Gap Filler" suggestions.
* **Dynamic Scaling:** Ingredient quantities in the shopping list scale automatically based on `HouseholdSize` (1-4+ people) and `ShoppingInterval` (e.g., 7 or 14 days).
* **Dual-View Grocery List:** * **Global List:** Consolidated view of all ingredients required (e.g., "6 Tomatoes").
    * **Meal-by-Meal View:** Breakdown of ingredients by specific recipe; users can adjust quantities per meal.
* **Pantry Filtering:** Items flagged in "The Pantry" are automatically hidden from the "To Buy" section.

### C. The "Store-Side" Assistant (In-Scan Action)
* **Scan-to-Recipe:** Snapshot a vegetable in-store (e.g., Romanesco broccoli). The app triggers recipe ideas that:
    1. Specifically use that ingredient.
    2. Fill your current nutritional gaps (based on the Rainbow Wheel).
    3. Respect your allergy and taste configurations.

### D. Gamification & Motivation
* **The Streak Flame:** Tracks consecutive days with at least 2 meals logged.
* **Rainbow Haptics:** A celebration when a user hits all core nutrient targets for the week.
* **Variety Badges:** Milestones for food diversity (e.g., "10 Different Vegetables this Week").

---

## 3. Configuration & Personalization
* **Deficiency Focus:** Users toggle specific vitamins/minerals (e.g., Iron, Vitamin D, B12) to prioritize in the Recommendation Engine.
* **Allergies & Tastes:** Strict exclusion of allergens and a "like/dislike" weighting for automated suggestions.

---

## 4. App Structure & Navigation (iOS Tab Bar)
The app follows standard iOS patterns with a 4-tab system and a central Action Button.

1.  **Dashboard:** Rainbow Wheel, Today's Meals, and the Recommendation Engine.
2.  **Library:** Central hub for **Pantry**, **Saved Recipes**, and **Discovery Lab**.
3.  **[CENTER SCAN BUTTON]:** Universal camera trigger. Toggle between "Meal Log" and "Grocery Scan-to-Recipe."
4.  **Shopping List:** Toggle between Global and Meal-based views.
5.  **Settings:** **Deficiency Focus**, **Allergies & Tastes**, and Household scaling logic.

---

## 5. iOS System Architecture & Data Flow (Dual-Storage Model)

### 1. Input Layer
* **Vision:** `Vision Framework` + `CoreML` identifies objects locally.
* **NLP Processing:** Strings are sent to **Edamam API** to convert "Natural Language" to nutrient JSON.

### 2. Logic Layer (SwiftData)
* **Local Persistence:** All meals, recipes, and nutrients are stored in the app's private SQLite database via SwiftData.
* **HealthKit Integration (Optional):** If authorized, data mirrors to `HKHealthStore`.

### 3. Intelligence Layer
* **Gap Analysis:** Queries **SwiftData** for the last 7 days of logs.
* **Recommendation Strategy:** Prioritizes **Spoonacular API** requests based on the user's `Deficiency Focus` toggles.

---

## 6. Data Model (SwiftData Schema)

| Entity | Attributes |
| :--- | :--- |
| **Meal** | `timestamp`, `photoData`, `isFavorite: Bool`, `Relationship: [Ingredient]` |
| **Recipe** | `name`, `yield: Int`, `nutritionalStrategyTags`, `Relationship: [Ingredient]` |
| **Ingredient** | `name`, `quantityValue`, `quantityUnit`, `nutrientJSON` |
| **PantryItem** | `name`, `isInStock: Bool`, `lastUpdated` |

---

## 7. Version History
* **v1.0.0:** Initial concept.
* **v1.1.0:** Added iOS Technical Flow, HealthKit integration, and NLP logic for gram-free tracking.
* **v1.2.0:** Updated architecture to a Dual-Storage model using **SwiftData** as the primary persistence layer.
* **v1.3.0:** Added Recipe Engine and Meal-driven Shopping List integration.
* **v1.4.0:** Removed Precision Logic; Added Pantry modules.
* **v1.5.0:** Restored Recipe Promotion, Scan-to-Recipe, and Scaling logic; Refined Dashboard (<5 / ≥5 rule).