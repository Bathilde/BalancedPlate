# Swift Style Guide & Coding Rules

## SwiftUI Observation & Features
- **Prefer `@Observable`**: Use the `@Observable` macro (iOS 17+) for ViewModels instead of `ObservableObject` and `@Published`.
- **Observation Import**: Only import `Observation` in files where the `@Observable` macro is explicitly used. Skip the import if it's already available through other core frameworks or if the macro is not present.
- **Modern Previews**: Always use the `#Preview` macro (Swift 5.9+) for View previews instead of the legacy `PreviewProvider`.

## Assets & Styling
- **Type-Safe Colors**: Use SwiftUI's automatically generated asset symbols (e.g., `.pinkAccent`) instead of manual `Color` extensions or string-based initializers.
- **Native Components**: Prioritize native SwiftUI components over `UIKit` wrappers unless absolutely necessary.
- **Layout Management**: Prefer using `.background()` and `.overlay()` modifiers instead of `ZStack` whenever possible for clarity. `ZStack` should be used as little as possible.

## Architecture
- **MVVM**: Strictly follow the Model-View-ViewModel pattern. 
- **Separation of Concerns**: Keep business logic, data handling, and storage in ViewModels or Services. Views should focus only on layout and presentation.

## Localization
- **No Hardcoded Strings**: All user-facing text MUST be moved to `Localizable.xcstrings`.
- **Usage**: Use `Text("key")` for automatic localization or `String(localized: "key")` for dynamic content.

## Design Aesthetics
- **Premium UI**: Use vibrant colors, smooth gradients, and micro-animations.
- **Dynamic Design**: Implement hover effects, capsule-shaped buttons (`PrimaryButtonStyle`), and responsive layouts.

## Data Models
- **Synthesized Codable**: If a struct is implementing the `Codable` protocol, avoid creating manual `CodingKeys` and `init(from decoder:)` unless absolutely necessary. Rely on the compiler's synthesized implementation as much as possible.
