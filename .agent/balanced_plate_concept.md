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

### A. The Dashboard: Beyond the Wheel
To avoid a cluttered UI, we replace the "busy wheel" with a compact **Favorite Nutrients Strip**.
* **Favorite Nutrients Strip:** Displays only the user’s favorited nutrients (up to ~3–5) as compact dynamic bars. This keeps the Dashboard glanceable and avoids overwhelming the user with all available nutrients at once.
    * A **right chevron (›)** at the end of the strip opens the full **Nutrient Detail View**, where all available nutrients are listed with their current fill level. Users can toggle any nutrient as a **Favorite** from this view, which updates what appears on the Dashboard.
* **Onboarding Preset:** During onboarding’s "Goal Setter" step, selecting health concerns (e.g., "Lack of Energy" → B12) automatically pre-selects up to **3 nutrients as Favorites**, giving the Dashboard a meaningful default state from day one.
* **The Status Widget:** A Home Screen widget showing the Top 3 Favorite Nutrients for the day and a "Log Last Meal" shortcut button.
* **Daily Log View:** Integrated directly under the Nutrient Strip for immediate access to today’s data. It features a scrollable list of the **Current Day's Meals** separated by meal type (Breakfast, Lunch, Dinner). The app uses time-awareness based on user-configured reminders to know the current meal context. Includes a primary "Scan Meal" button and a secondary "Add Manually" button to add items.
* **Search Fallback:** A "Quick Add" text field using NLP (Edamam) for when the camera cannot identify a complex meal or the user is logging after the fact.
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
* **Unit Localization:** The shopping list automatically converts recipe units based on the user's region.
    * **Metric:** Grams, Kilograms, Milliliters, Liters.
    * **Imperial/US:** Cups, Ounces, Pounds, Teaspoons/Tablespoons.
**Density-Aware Conversion:** Uses API data to ensure that "1 cup" is converted to the correct weight in grams based on the specific ingredient (e.g., Lead vs. Feathers logic).
* **Smart Merging:** When generating the Global List, the app attempts to merge identical ingredients using the Unit Manager. (e.g., "200g Spinach" + "100g Spinach" = "300g Spinach").

### C. The "Store-Side" Assistant (In-Scan Action)
* **Scan-to-Recipe:** Snapshot a vegetable in-store (e.g., Romanesco broccoli). The app triggers recipe ideas that:
    1. Specifically use that ingredient.
    2. Fill your current nutritional gaps (based on the Rainbow Wheel).
    3. Respect your allergy and taste configurations.

### D. Gamification & Motivation
* **The Streak Flame:** Tracks consecutive days with at least 2 meals logged.
* **Rainbow Haptics:** A celebration when a user hits all core nutrient targets for the week.
* **Variety Badges:** Milestones for food diversity (e.g., "10 Different Vegetables this Week").

### E. The Dual-View Grocery List (Updated)
* **Global List:** Consolidated view (e.g., "750g Tomatoes" or "1.5 lbs Tomatoes").
* **Meal-by-Meal View:** Ingredients grouped by recipe.
* **User Control:** Users can tap an ingredient to toggle its unit manually if they prefer to buy "1 bag" instead of "500g."
* **Navigation & Actions:** The navigation bar is kept clean without complex filter buttons. A "Scan Ingredient" button is anchored at the bottom of the view to quickly find recipe inspiration based on items found in-store.

### G. The Recipe Book *(renamed from Library)*
The Recipe Book is the user's personal culinary hub. It is split into three areas: **Pantry**, **My Recipes**, and **Explore**.

* **My Recipes:** A list of saved recipes, each displayed as a card containing:
    * Recipe name and thumbnail.
    * **"Best for"** label followed by 2–3 nutrient tags (e.g., 🟠 Iron · 🟡 B12) derived from the recipe's `nutritionalStrategyTags`. This gives users an at-a-glance understanding of why a recipe is in their book.
* **Explore Button:** At the bottom of the My Recipes list, an **"Explore"** button opens a discovery screen showing a curated list of recipes from Spoonacular (filtered by the user's allergies and preferences). Users can browse and tap **"Add to Recipe Book"** on any recipe to save it.
* **Pantry:** The existing pantry management view (staples and in-stock items).

### F. Smart Onboarding Flow
A 4-step guided setup to initialize the SwiftData user profile and the Recommendation Engine.

#### 1. The "Health Filter" (Constraints)
* **Allergies:** Common triggers (Nuts, Dairy, Gluten, Shellfish).
* **Dietary Preferences:** Toggles for Vegan, Vegetarian, Pescatarian, or "No Restrictions."

#### 2. The "Goal Setter" (Nutrient Focus)
* **Multi-select list of concerns:** (e.g., "Lack of Energy" → B12, "Bone Health" → Vitamin D/Calcium, "Anemia" → Iron).
* **Benefit:** This sets the priority weights for the Bridge Meal suggestions, and automatically marks up to **3 mapped nutrients as Favorites** so the Dashboard is immediately populated with meaningful data.

#### 3. The "Quick Start" Pantry
A curated list of "Pantry Staples." Users tap to check off items they already own (Olive oil, Rice, Salt, Flour).
* **Benefit:** Prevents these items from cluttering the first generated shopping list.

#### 4. The "Habit" Prerecord
"What do you usually eat for Breakfast/Lunch?"
* **Users can select common templates** (e.g., "Oatmeal," "Two Eggs & Toast") to pre-populate their Library as "Quick-Log" items.

#### 5. Household Size
* **Onboarding ends by asking:** "Who are we cooking for?" (1, 2, or 4+ people).

#### 6. Meal Time Rhythm
* **Onboarding "Rhythm" Setup:** During onboarding, users define their typical meal times (Breakfast, Lunch, Dinner).

#### 7. The "Success" Screen (The Result)
* **The "First Bridge" Reveal:** The app displays: "Based on your feeling (Tired) and your Pantry (Eggs, Spinach), here is your first Bridge Meal: The 5-Minute Power Omelette."
* **Action:** Buttons to "Cook This Now" (Log it) or "Add Ingredients to Shopping List."

### H. The Notification & Reminder Engine
To ensure the "User Success Loop," notifications are treated as helpful nudges rather than spam.

* **Onboarding "Rhythm" Setup:** During onboarding, users define their typical meal times (Breakfast, Lunch, Dinner).
* **Smart Reminders:** Notifications triggered 30 minutes after a scheduled meal time if no log has been made.
* **Weekly Wins:** A Sunday morning notification summarizing the "Nutrient Diversity" of the week with a "Success Badge."

---

## 3. Configuration & Personalization
* **Unit System Toggle:** Choose between Metric, Imperial (US), or Imperial (UK).
* **Deficiency Focus:** Users toggle specific vitamins/minerals (e.g., Iron, Vitamin D, B12) to prioritize in the Recommendation Engine.
* **Allergies & Tastes:** Strict exclusion of allergens and a "like/dislike" weighting for automated suggestions.
* **Localized Defaults:** The app automatically detects the iOS locale to set Unit Systems (Metric vs. Imperial) and Currency. No user input is required unless they wish to override in Settings.
* **Household Scaling:** Onboarding ends by asking: "Who are we cooking for?" (1, 2, or 4+ people).
* **Notification Toggles:** Granular control over meal reminders and weekly analysis.
* **Terms & Privacy:** Standard legal links for MVP compliance.
* **App Review Trigger:** The "Rate Us" prompt is only triggered after a "Success Moment" (e.g., completing the 72h log or checking off a full "Bridge Meal" shopping list).

---

## 4. App Structure & Navigation (iOS Tab Bar)
The app follows standard iOS patterns with a 4-tab system.

1.  **Dashboard:** Favorite Nutrients Strip, Today's Meals, and the Recommendation Engine.
2.  **Recipe Book** *(formerly "Library"):* Central hub for **Pantry**, **Saved Recipes**, and **Discovery Lab**. See Section G below for details.
3.  **Shopping List:** Toggle between Global and Meal-based views.
4.  **Settings:** **Deficiency Focus**, **Allergies & Tastes**, and Household scaling logic.

---

## 5. The User Success Loop (The Habit Flywheel)
* **Trigger:** Smart Notification (Meal time) or Widget glance.
* **Action:** "Quick-Log" from favorites or a 2-second Photo Scan.
* **Variable Reward:** Visual "fill" of the Mosaic tiles + Haptic feedback.
* **Investment:** "Meal-to-Recipe Promotion" or adding a "Bridge Meal" to the shopping list for the weekend.

---

## 6. iOS System Architecture & Data Flow (Dual-Storage Model)

### 1. Input Layer
* **Vision:** `Vision Framework` + `CoreML` identifies objects locally.
* **NLP Processing:** Strings are sent to **Edamam API** to convert "Natural Language" to nutrient JSON.

### 2. Logic Layer (SwiftData)
* **Unit Manager:** A Swift service that checks the user's UnitSystem preference.
* **Conversion:** If the preference is Metric but the input is Cups, the app displays the API-provided gram weight.
* **Local Persistence:** All meals, recipes, and nutrients are stored in the app's private SQLite database via SwiftData.
* **HealthKit Integration (Optional):** If authorized, data mirrors to `HKHealthStore`.

### 3. Intelligence Layer
* **Gap Analysis:** Queries **SwiftData** for the last 7 days of logs.
* **Recommendation Strategy:** Prioritizes **Spoonacular API** requests based on the user's `Deficiency Focus` toggles.

### 4. The Onboarding "Win" Logic
* **Step 1-5:** Data is written to `UserProfile` in SwiftData.
* **Step 6 (Success):** The app triggers an immediate POST to the Spoonacular API using the `includeIngredients` (from Pantry) and `targetNutrients` (from Symptoms) parameters.
* **Storage:** This first "Bridge Meal" is saved to the `Discovery Lab` so the user doesn't lose it.

### 5. Notification Logic
* **Local Notifications:** MVP uses UserNotifications framework to schedule reminders locally based on the user's "Rhythm" settings, avoiding the need for a push server.

---

## 7. Data Model (SwiftData Schema)

| Entity | Attributes |
| :--- | :--- |
| **Meal** | `timestamp`, `photoData`, `isFavorite: Bool`, `Relationship: [Ingredient]` |
| **Recipe** | `name`, `yield: Int`, `nutritionalStrategyTags`, `Relationship: [Ingredient]` |
| **Ingredient** | `name`, `rawInputUnit: String`, `standardizedWeightGrams: Double`, `displayAmount: Double`, `displayUnit: String` |
| **PantryItem** | `name`, `isStaple: Bool`, `isInStock: Bool`, `lastUpdated` |
| **UserSetting** | `preferredUnitSystem: UnitEnum`, `householdSize: Int`, `deficiencyFocus: [Nutrient]`, `symptoms: [SymptomEnum]` |
| **OnboardingResult** | `firstSuggestedMealID`, `dateGenerated` |

---

## 8. Version History
* **v1.0.0:** Initial concept.
* **v1.1.0:** Added iOS Technical Flow, HealthKit integration, and NLP logic for gram-free tracking.
* **v1.2.0:** Updated architecture to a Dual-Storage model using **SwiftData** as the primary persistence layer.
* **v1.3.0:** Added Recipe Engine and Meal-driven Shopping List integration.
* **v1.4.0:** Removed Precision Logic; Added Pantry modules.
* **v1.5.0:** Restored Recipe Promotion, Scan-to-Recipe, and Scaling logic; Refined Dashboard (<5 / ≥5 rule).
* **v1.6.0:** Added Global Unit Localization and Density-Aware Conversion to handle Metric/Imperial differences.
* **v1.7.0:** Added Smart Onboarding Flow with Symptom Mapping and Immediate Success (First Bridge Meal).
* **v1.8.0:** Added Search Fallback, Smart Merging for shopping lists.
* **v1.9.0:** Replaced "Wheel" with Nutrient Mosaic; Added User Success Loop, Home Screen Widgets, and Smart Notification Rhythm.
* **v1.10.0:** Updated Tab Bar to 4 items, enhanced Daily Log View with meal types and actions, refined Shopping List actions.
* **v1.11.0:** Replaced Nutrient Mosaic with compact Favorite Nutrients Strip; added Nutrient Detail View with favorites toggle; onboarding presets 3 favorites from goal selection; renamed Library to Recipe Book; added "Best for" nutrient tags and Explore button to Recipe Book.
