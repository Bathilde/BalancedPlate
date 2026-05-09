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
* **Diversity Score:** A visual dashboard (e.g., a "Rainbow Wheel") showing which food groups or micronutrient categories (B-Vitamins, Fat-Soluble Vitamins, Minerals) have been covered over the last 7 days.

### B. The "Gap Filler" (Recommendation Engine)
* **Weekly Aggregate Analysis:** Queries HealthKit for the last 7 days of micronutrient data.
* **Bridge Meal Suggestions:** Uses the **Spoonacular API** or **Edamam** to fetch recipes based on missing nutrients.

### C. The "Store-Side" Assistant
* **Scan-to-Recipe:** Mobile-first feature using the camera to trigger immediate recipe ideas based on seasonal availability.

---

## 3. Configuration & Personalization
* **Deficiency Focus:** Users can toggle specific vitamins/minerals they are concerned about (e.g., Iron, Vitamin D, B12).
* **Allergies & Tastes:** Strict exclusion of allergens and a "like/dislike" weighting for recipe suggestions.
* **Quantities:** Ability to set shopping list logic (e.g., "I shop for 2 people every 10 days").

---

## 4. Technical Considerations (The "Precision" Logic)
The app uses a **Coefficient of Loss** model ($L$):
* **Base Value ($V_b$):** Sourced from Nutrition NLP APIs using "average household sizes" (e.g., "1 medium bell pepper").
* **Final Value ($V_f$):** Calculated as $V_f = V_b \times L_{prep} \times L_{time}$
    * $L_{prep}$: Cooking method (Steamed: 0.9, Boiled: 0.6).
    * $L_{time}$: Time since prep (Fresh: 1.0, 1h+ Pre-cut: 0.7).

---

## 5. iOS System Architecture & Data Flow

To ensure doability and privacy, the app follows this flow:

### 1. Input Layer (The "What")
* **Vision:** `Vision Framework` + `CoreML` identifies objects in the frame.
* **NLP Processing:** The identified strings (e.g., "3 Carrots") are sent to the **Edamam Nutrition Analysis API**. 
    * *Why:* This converts "Natural Language" into structured nutrient JSON without requiring gram inputs from the user.

### 2. Logic Layer (The "How")
* **Nutrient Adjustment:** A custom Swift service applies the "Coefficient of Loss" logic to the JSON response.
* **HealthKit Integration:** The adjusted data is written to `HKHealthStore` using `HKQuantityTypeIdentifier` (e.g., `.dietaryVitaminC`).

### 3. Intelligence Layer (The "Why")
* **Gap Analysis:** The app performs an `HKSampleQuery` to fetch the user's weekly nutrient totals.
* **Recommendation:** If $Total < Threshold$, the app triggers a `GET` request to a recipe API with the filter `minVitaminC=X`.

| Component | Technology | Role |
| :--- | :--- | :--- |
| **API** | Edamam / Nutritionix | Converts "1 Apple" to nutrient JSON. |
| **Storage** | Apple HealthKit | Centralized nutrient database (Private & Secure). |
| **Search** | Spoonacular API | Finds recipes by missing micronutrients. |
| **Location** | CoreLocation | Determines seasonality based on climate zone. |

---

## 6. Version History
* **v1.0.0:** Initial concept.
* **v1.1.0:** Added iOS Technical Flow, HealthKit integration, and NLP logic for gram-free tracking.