//
//  Label+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/9.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(_ titleKey: LocalizedStringKey, symbol: SFSymbol) {
        self.init(titleKey, systemImage: symbol.rawValue)
    }
}
