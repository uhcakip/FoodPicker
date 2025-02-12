<div align="center">
  <h1>FoodPicker</h1>

  <p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank"><img src="https://img.shields.io/badge/Swift-6.0-585b70?logo=swift&amp;style=for-the-badge&amp;labelColor=313244&amp;logoColor=fab387" alt="Swift 6.0"></a>
    <a href="https://developer.apple.com/xcode/" target="_blank"><img src="https://img.shields.io/badge/Xcode-16.2-585b70?logo=Xcode&amp;style=for-the-badge&amp;labelColor=313244&amp;logoColor=89b4fa" alt="Xcode 16.2"></a>
    <a href="https://developer.apple.com/ios/" target="_blank"><img src="https://img.shields.io/badge/iOS-18.2-585b70?logo=apple&amp;style=for-the-badge&amp;labelColor=313244&amp;logoColor=cdd6f4" alt="iOS 18.2"></a>
  </p>

  <h3>🖼️ Screenshots</h3>

  <div>
    <img src="https://github.com/user-attachments/assets/a9477bd3-76d0-45f7-83aa-f5f55d23f610" width="25%" alt="Home">&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/user-attachments/assets/66315594-c9c6-4132-b6d4-989174186a00" width="25%" alt="Picker">&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/user-attachments/assets/91be7d15-c133-4a4c-92b7-45acf78d43f7" width="25%" alt="List">
    <br><br>
    <img src="https://github.com/user-attachments/assets/4dda504d-2b16-4b24-ad98-4dad0adfe809" width="25%" alt="List - Edit">&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/user-attachments/assets/c7d8ea0c-759d-492c-8d1e-c4d8d0143bcb" width="25%" alt="Sheet - Food Detail">&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/user-attachments/assets/f1c3fbbf-2f9b-4c7c-b290-633c26bf75bd" width="25%" alt="Sheet - Form (Edit)">&nbsp;&nbsp;&nbsp;
    <br><br>
    <img src="https://github.com/user-attachments/assets/0f70dc47-31c5-4e46-9456-642fa6a427bc" width="25%" alt="Sheet - Form (Add)">&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/user-attachments/assets/e9251a9f-5ca2-413f-9e61-258beb8d01ea" width="25%" alt="Setting">
  </div>

  <h3>🎬 Demo</h3>

  https://github.com/user-attachments/assets/283a9ac1-1438-4938-b6e1-c7b81875430e
</div>

## Features

- **Persistent Settings**: Stores and retrieves settings like dark mode, custom unit selections, and the food list
  through a custom [
  `AppStorageCodable`](https://github.com/uhcakip/FoodPicker/blob/main/FoodPicker/Utils/Wrappers/AppStorageCodable.swift)
  property wrapper.
- **iOS 18 Tab Interface**: Leverages iOS 18's new [Tab](https://developer.apple.com/documentation/swiftui/tab) API.
- **Custom Keyboard Toolbar**: Provides a custom keyboard toolbar that enables users to navigate between different text
  input fields.
- **Unit Testing**: Implements tests for the [
  `Suffix`](https://github.com/uhcakip/FoodPicker/blob/main/FoodPicker/Utils/Wrappers/Suffix.swift) property wrapper
  using [Swift Testing](https://developer.apple.com/documentation/testing/).
- **Code Formatting & Linting**: Uses [swift-format](https://github.com/swiftlang/swift-format) for automated code
  formatting and linting. The project includes a
  build phase script that automatically runs swift-format commands to verify code style and consistency.

## Project Structure

```
.
├── FoodPicker
│   ├── Constants
│   │   ├── FoodUnit.swift
│   │   ├── SFSymbol.swift
│   │   └── StorageKey.swift
│   ├── Extensions
│   │   ├── Animation+.swift
│   │   ├── AnyLayout+.swift
│   │   ├── AnyTransition+.swift
│   │   ├── Image+.swift
│   │   ├── Label+.swift
│   │   ├── NumberFormatter+.swift
│   │   ├── Picker+.swift
│   │   ├── ShapeStyle+.swift
│   │   ├── Tab+.swift
│   │   ├── Toggle+.swift
│   │   ├── UIKeyboardType+.swift
│   │   └── View+.swift
│   ├── FoodPickerApp.swift
│   ├── Info.plist
│   ├── Models
│   │   └── Food.swift
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Screens
│   │   ├── FoodList
│   │   │   ├── FoodListScreen.swift
│   │   │   └── Views
│   │   │       ├── FoodDetailView.swift
│   │   │       ├── FoodFormView.swift
│   │   │       └── FoodSheetView.swift
│   │   ├── FoodPicker
│   │   │   └── FoodPickerScreen.swift
│   │   ├── Home
│   │   │   └── HomeScreen.swift
│   │   └── Setting
│   │       └── SettingScreen.swift
│   └── Utils
│       └── Wrappers
│           ├── AppStorageCodable.swift
│           └── Suffix.swift
├── FoodPickerTests
│   ├── SuffixTest.swift
│   └── Unit Tests.xctestplan
```

## Packages

This project uses Swift Package Manager (SPM) to manage its dependencies:

- [Inject](https://github.com/krzysztofzablocki/Inject) – For hot reloading during development.
