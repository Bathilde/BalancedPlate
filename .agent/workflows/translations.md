---
description: Ensure all views use localized strings with the correct key format in Seekeer/Localizable.xcstrings
---

# Workflow: Translations

Follow these steps whenever creating or updating a SwiftUI View to ensure consistent and correct localization.

### 1. Identify the Key Components
Based on the file path `Seekeer/Modules/[ModuleName]/[ViewName]/[FileName].swift` or `Seekeer/Modules/[ModuleName]/Views/[FileName].swift`:
- **[module name]**: The name of the module (e.g., `onboarding`, `main`, `profile`). Always lowercase.
- **[view name]**: The name of the view or subview file (e.g., `questionview`, `proofoflifedescriptionview`). Always lowercase.
- **[component]**: The type of UI element (e.g., `text`, `button`, `textfield`, `placeholder`).
- **[key]**: A descriptive name for the specific string (e.g., `title`, `subtitle`, `label`, `action`).

**Final Key Format**: `[module name].[view name].[component].[key]`

### 2. Update Localizable.xcstrings
Before using a string in a View, add it to `Seekeer/Localizable.xcstrings`.
- **STRICT RULE**: You are NOT allowed to edit or modify existing keys. You must ONLY add new keys or entries.
- Open `Seekeer/Localizable.xcstrings`.
- Add a new entry in the `strings` object following the format below.
- Set `extractionState` to `manual`.
- Set the `state` to `translated` and provide the English `value`.

```json
"module.view.component.key" : {
  "extractionState" : "manual",
  "localizations" : {
    "en" : {
      "stringUnit" : {
        "state" : "translated",
        "value" : "Your String Here"
      }
    }
  }
}
```

### 3. Use in SwiftUI View
Replace all hardcoded strings in the View with their localized keys.
- Use `Text("module.view.component.key")` for text.
- Use `String(localized: "module.view.component.key")` for strings in non-Text contexts (like button titles or placeholders if not using the Text-based initializer).
- Buttons using labels: `Button { ... } label: { Text("module.view.component.key") }`.

### 4. Verification Check
- Ensure no hardcoded strings remain in the `.swift` file.
- Verify that the key follows the `[module].[view].[component].[key]` structure exactly.
- Confirm that the string is correctly displayed in the app/preview.
