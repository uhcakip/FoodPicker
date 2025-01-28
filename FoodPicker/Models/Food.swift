//
//  Food.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/22.
//

import Foundation

struct Food: Equatable, Identifiable, Codable {
    var id = UUID()
    var name: String
    var emoji: String
    @Suffix("kcal") var calorie: Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero

    static let examples = [
        Self(name: "Burger", emoji: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Self(name: "Salad", emoji: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Self(name: "Pizza", emoji: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Self(name: "Spaghetti", emoji: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Self(name: "Chicken Bento", emoji: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Self(name: "Hot Pot", emoji: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Self(name: "Beef Noodles", emoji: "🐄🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Self(name: "Oden", emoji: "🥘", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]

    static var new: Self {
        //.init(name: "", emoji: "")
        Self(name: "", emoji: "")
    }
}
