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
The app analyzes your "Diversity Score" to identify what is missing from your diet.
* **Weekly Aggregate Analysis:** It doesn't nag you daily. On a set day, it identifies gaps (e.g., "You haven't had much Zinc this week").
* **Bridge Meal Suggestions:** Recommends specific recipes to "bridge the gap" between your current state and your nutritional goals.
* **Configurable Household Logic:** * Adjusts ingredient quantities for different household sizes (Single, Couple, Family of 4).
    * Scales shopping lists for specific durations (e.g., 1 week vs. 2 weeks).

### C. The "Store-Side" Assistant (Seasonal & Real-time)
A feature for spontaneous shoppers who want to eat fresh.
* **Seasonality Awareness:** Based on your location, the app highlights what is currently "at its peak" (and therefore highest in nutrients).
* **Scan-to-Recipe:** See a vegetable (e.g., Romanesco broccoli), snap a photo, and the app suggests 3 recipes that:
    1.  Use that ingredient.
    2.  Fill your current nutritional gaps.
    3.  Match your taste preferences and allergies.
* **Dynamic Shopping List:** Once a recipe is selected, the app adds only the *missing* ingredients to your list, assuming you have basic pantry staples.

---

## 3. Configuration & Personalization
* **Deficiency Focus:** Users can toggle specific vitamins/minerals they are concerned about (e.g., Iron, Vitamin D, B12).
* **Allergies & Tastes:** Strict exclusion of allergens and a "like/dislike" weighting for recipe suggestions.
* **Quantities:** Ability to set shopping list logic (e.g., "I shop for 2 people every 10 days").

---

## 4. Technical Considerations (The "Precision" Logic)
The app uses a **Coefficient of Loss** model instead of raw numbers:
* **Vitamin C ($C_6H_8O_6$):** Logic accounts for rapid oxidation. If a salad is logged 2 hours after a "pre-cut" purchase, the nutrient weight is automatically de-rated.
* **Cooking Impact:** Logic applies a percentage reduction to heat-sensitive nutrients (B-vitamins, C) while potentially increasing the bioavailability of others (like Lycopene in tomatoes).

---

## 5. Version History
* **v1.0.0:** Initial concept focusing on visual tracking, gap-filling recommendations, and seasonal store-side assistance.
