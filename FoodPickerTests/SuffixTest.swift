//
//  SuffixTest.swift
//  FoodPickerTests
//
//  Created by Yuna Chou on 2025/2/7.
//

import Testing

@testable import FoodPicker

struct SuffixTest {
    @AppStorageCodable(.selectedWeightUnit) var selectedUnit: WeightUnit

    @Test(
        "Convert gram value to ounce string representation when selected unit is pound",
        arguments: [(100, "3.5 oz"), (-300.456, "-10.6 oz"), (200.567, "7.1 oz")]
    )
    func gramToOunceConversion(value: Double, expected: String) {
        withKnownIssue("Currently using UserDefaults.standard; an additional testing store is required for tests.") {
            let sut = Suffix(wrappedValue: value, WeightUnit.gram)
            #expect(sut.description == expected)
        } when: {
            selectedUnit == .gram
        }
    }

    @Test(
        "Convert ounce value to gram string representation when selected unit is gram",
        arguments: [(3.5, "99.2 g"), (-10.6, "-300.5 g"), (7.1, "201.3 g")]
    )
    func ounceToGramConversion(value: Double, expected: String) {
        withKnownIssue("Currently using UserDefaults.standard; an additional testing store is required for tests.") {
            let sut = Suffix(wrappedValue: value, WeightUnit.ounce)
            #expect(sut.description == expected)
        } when: {
            selectedUnit == .ounce
        }
    }
}
