//
//  SuffixTest.swift
//  FoodPickerTests
//
//  Created by Yuna Chou on 2025/2/7.
//

import Foundation
import Testing

@testable import FoodPicker

struct SuffixTest {
    private static let store = UserDefaults.init(suiteName: #file)!

    @Suite(.serialized) struct UnitConversion {
        @AppStorageCodable(.selectedWeightUnit, store: store) var selectedUnit: WeightUnit

        init() async throws {
            UserDefaults.standard.removePersistentDomain(forName: #file)
        }

        @Test(
            "Convert gram value to ounce string representation when selected unit is pound",
            arguments: [(100, "3.5 oz"), (-300.456, "-10.6 oz"), (200.567, "7.1 oz")]
        )
        func gramToOunceConversion(value: Double, expected: String) {
            selectedUnit = .ounce
            let sut = Suffix(wrappedValue: value, WeightUnit.gram, store: store)
            #expect(sut.description == expected)
        }

        @Test(
            "Convert ounce value to gram string representation when selected unit is gram",
            arguments: [(3.5, "99.2 g"), (-10.6, "-300.5 g"), (7.1, "201.3 g")]
        )
        func ounceToGramConversion(value: Double, expected: String) {
            let sut = Suffix(wrappedValue: value, WeightUnit.ounce, store: store)
            #expect(sut.description == expected)
        }
    }
}
