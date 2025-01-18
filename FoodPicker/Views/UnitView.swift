//
//  UnitView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/17.
//

import SwiftUI

enum UnitView: String, View, CaseIterable, Identifiable {
    case gram = "g"
    case pound = "lb"

    var id: Self { self }

    var body: some View {
        Text(rawValue)
    }
}
