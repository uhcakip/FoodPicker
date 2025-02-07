//
//  SuffixTest.swift
//  FoodPickerTests
//
//  Created by Yuna Chou on 2025/2/7.
//

import Testing

@testable import FoodPicker

struct SuffixTest {
    @Test(
        "Convert integer to string without decimals",
        arguments: [(100, "100"), (-42, "-42")]
    )
    func formatIntegerWithoutDecimals(value: Double, expected: String) {
        let sut = Suffix(wrappedValue: value)
        #expect(sut.projectedValue == expected)
    }

    @Test(
        "Round decimal to one decimal place",
        arguments: [(100.567, "100.6"), (100.432, "100.4"), (-100.456, "-100.5")]
    )
    func roundDecimalToOnePlace(value: Double, expected: String) {
        let sut = Suffix(wrappedValue: value)
        #expect(sut.projectedValue == expected)
    }

    @Test(
        "Append unit suffix with a space",
        arguments: [(100, "g", "100 g"), (-42.567, "kcal", "-42.6 kcal")]
    )
    func appendSuffixWithSpace(value: Double, suffix: String, expected: String) {
        let sut = Suffix(wrappedValue: value, suffix)
        #expect(sut.projectedValue == expected)
    }
}
