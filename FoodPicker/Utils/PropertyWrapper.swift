//
//  PropertyWrapper.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/25.
//

import SwiftUI

@propertyWrapper
struct Suffix<Unit: FoodUnit & Equatable>: Equatable, Codable {
    var wrappedValue: Double
    var unit: Unit

    init(wrappedValue: Double, _ unit: Unit) {
        self.wrappedValue = wrappedValue
        self.unit = unit
    }

    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }

    var description: String {
        let selectedUnit = Unit.getSelection()
        let converted = Measurement(value: wrappedValue, unit: unit.dimension).converted(to: selectedUnit.dimension)
        return converted.formatted(
            .measurement(
                width: .abbreviated,
                usage: .asProvided,
                numberFormatStyle: .number.precision(.fractionLength(0...1))
            )
        )
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

extension AppStorageCodable where Value: FoodUnit {
    init(_ key: StorageKey, store: UserDefaults? = nil) {
        self.init(wrappedValue: Value.defaultValue, key, store: store)
    }
}
