//
//  SuffixTest.swift
//  FoodPickerTests
//
//  Created by Yuna Chou on 2025/2/7.
//

import XCTest

@testable import FoodPicker

final class SuffixTest: XCTestCase {
    var sut: Suffix!

    func test_projectedValue_integerNumber_shouldReturnStringWithoutDecimal() {
        sut = .init(wrappedValue: 100)
        XCTAssertEqual(sut.projectedValue, "100")
    }

    func test_projectedValue_decimalNumber_shouldRoundToOneDecimalPlace() {
        sut = .init(wrappedValue: 100.567)
        XCTAssertEqual(sut.projectedValue, "100.6")

        sut = .init(wrappedValue: 100.432)
        XCTAssertEqual(sut.projectedValue, "100.4")

        sut = .init(wrappedValue: -100.456)
        XCTAssertEqual(sut.projectedValue, "-100.5")
    }

    func test_projectedValue_numberWithSuffix_shouldIncludeSuffixWithSpace() {
        sut = .init(wrappedValue: 100, "g")
        XCTAssertEqual(sut.projectedValue, "100 g")

        sut = .init(wrappedValue: 100.1, "kcal")
        XCTAssertEqual(sut.projectedValue, "100.1 kcal")
    }
}
