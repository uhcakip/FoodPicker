//
//  PropertyWrappers.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/25.
//

import Foundation

@propertyWrapper
struct Suffix: Equatable {
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
