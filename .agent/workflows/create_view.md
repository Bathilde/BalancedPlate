---
description: Create a new SwiftUI View following the Swift Style Guide
---

# Workflow: Create View Component

Follow these steps to create a new module or view component in the Seekeer app.

### 1. Create the ViewModel
Create a new file in `Seekeer/Modules/[ModuleName]/ViewModels/[ViewName]ViewModel.swift`.
- Use the `@Observable` macro.
- Import `Observation` (only if necessary).
- Handle any business logic or service interactions here.
- // turbo
```bash
# Example
touch Seekeer/Modules/Onboarding/ViewModels/ExampleViewModel.swift
```

### 2. Add Localized Strings
Follow the steps in [Translations Workflow](translations.md) to add strings to `Seekeer/Localizable.xcstrings`.
- Use the format: `[module_name].[view_name].[component].[key]`.

### 3. Create the View
Create a new file in `Seekeer/Modules/[ModuleName]/Views/[ViewName].swift`.
- Use `Text("key")` for all labels.
- Use `PrimaryButtonStyle()` or `SecondaryButtonStyle()` for buttons.
- Use asset colors (e.g., `.pinkAccent`).
- Keep the view focused on layout.
- Use `@State private var viewModel = [ViewName]ViewModel()` for observation.

### 4. Previews
- Use modern `#Preview`.
- Use `@Previewable` for state variables inside the preview block (Modern Swift).

### 5. Verify & Polish
- Check that the navigation bar is handled (hidden/shown as needed).
- Ensure consistent padding and spacing (usually `spacing: 24` or similar).
- Verify the view is responsive.
