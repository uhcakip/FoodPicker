//
//  PropertyWrapper.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/25.
//

import SwiftUI

@propertyWrapper
struct Suffix: Equatable, Codable {
    var wrappedValue: Double
    private let suffix: String

    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }

    var projectedValue: String {
        wrappedValue.formatted() + " \(suffix)"
    }
}

/// A property wrapper that extends `AppStorage` to support storing `Codable` values
/// in `UserDefaults` with automatic JSON encoding and decoding.
///
/// This is particularly useful for storing complex data types in UserDefaults
/// with the simplicity of SwiftUI Bindings.
///
/// ```swift
/// struct SettingScreen: View {
///     @AppStorageCodable(.shouldUseDarkMode) private var shouldUseDarkMode = false
///
///     var body: some View {
///         Toggle("Dark Mode", isOn: $shouldUseDarkMode)
///         // other views...
///     }
/// }
/// ```
@propertyWrapper
struct AppStorageCodable<Value: Codable>: DynamicProperty {
    @AppStorage private var data: Data
    private let key: StorageKey.RawValue
    private let defaultValue: Value
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(wrappedValue: Value, _ key: StorageKey, store: UserDefaults? = nil) {
        self.key = key.rawValue
        self.defaultValue = wrappedValue
        _data = .init(
            wrappedValue: (try? encoder.encode(defaultValue)) ?? Data(),
            key.rawValue,
            store: store
        )
    }

    /// The decoded value stored in UserDefaults or the default value.
    public var wrappedValue: Value {
        get { (try? decoder.decode(Value.self, from: data)) ?? defaultValue }
        nonmutating set { data = (try? encoder.encode(newValue)) ?? data }
    }

    /// A Binding to the stored value, allowing for two-way data flow.
    var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}
