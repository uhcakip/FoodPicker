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
    @Suffix("大卡") var calorie: Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero

    static let examples = [
        Self(name: "漢堡", emoji: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Self(name: "沙拉", emoji: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Self(name: "披薩", emoji: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Self(name: "義大利麵", emoji: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Self(name: "雞腿便當", emoji: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Self(name: "刀削麵", emoji: "🍜", calorie: 256, carb: 56, fat: 1, protein: 8),
        Self(name: "火鍋", emoji: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Self(name: "牛肉麵", emoji: "🐄🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Self(name: "關東煮", emoji: "🥘", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]

    static var new: Self {
        //.init(name: "", emoji: "")
        Self(name: "", emoji: "")
    }
}
