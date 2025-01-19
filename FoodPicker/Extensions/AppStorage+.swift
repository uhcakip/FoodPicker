//
//  AppStorage+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/19.
//

import SwiftUI

extension AppStorage {
    init(
        wrappedValue: Value,
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }

    init(
        wrappedValue: Value,
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
}
