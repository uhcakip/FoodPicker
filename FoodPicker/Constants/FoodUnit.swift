//
//  FoodUnit.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/2/10.
//

import Foundation

protocol FoodUnit: CaseIterable, Identifiable, Codable, RawRepresentable where RawValue == String {
    associatedtype T: Dimension

    static var storageKey: StorageKey { get }
    static var defaultValue: Self { get }

    var dimension: T { get }
    var localizedSymbol: String { get }
}

extension FoodUnit {
    var id: Self { self }
}

extension FoodUnit {
    static func getSelection() -> Self {
        AppStorageCodable(storageKey).wrappedValue
    }

    var localizedSymbol: String {
        MeasurementFormatter().string(from: dimension)
    }
}

enum WeightUnit: String, FoodUnit {
    static var storageKey = StorageKey.selectedWeightUnit
    static var defaultValue = Self.gram

    case gram
    case ounce

    var dimension: UnitMass {
        switch self {
        case .gram: .grams
        case .ounce: .ounces
        }
    }
}

enum EnergyUnit: String, FoodUnit {
    static var storageKey = StorageKey.selectedEnergyUnit
    static var defaultValue = Self.kcal

    case kcal

    var dimension: UnitEnergy {
        switch self {
        case .kcal: .calories
        }
    }
}
