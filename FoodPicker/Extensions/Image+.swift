//
//  Image+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/9.
//

import SwiftUI

extension Image {
    init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
