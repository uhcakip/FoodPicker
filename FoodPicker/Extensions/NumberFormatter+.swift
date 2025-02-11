//
//  NumberFormatter+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/2/10.
//

import Foundation

extension NumberFormatter {
    static let foodNutrition: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .halfUp
        formatter.zeroSymbol = ""  // Display an empty string for zero values in the TextField.
        return formatter
    }()
}
