//
//  Unit.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/17.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable, Codable {
    case gram = "g"
    case pound = "lb"

    var id: Self { self }
}
