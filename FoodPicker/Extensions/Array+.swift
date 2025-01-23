//
//  Array+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/23.
//

import Foundation

extension Array: @retroactive RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let array = try? JSONDecoder().decode(Self.self, from: data)
        else { return nil }
        self = array
    }

    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let string = String(data: data, encoding: .utf8)
        else { return "" }
        return string
    }
}
