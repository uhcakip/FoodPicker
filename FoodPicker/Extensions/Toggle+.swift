//
//  Toggle+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/16.
//

import SwiftUI

extension Toggle where Label == SwiftUI.Label<Text, Image> {
    init(_ titleKey: LocalizedStringKey, symbol: SFSymbol, isOn: Binding<Bool>) {
        self.init(titleKey, systemImage: symbol.rawValue, isOn: isOn)
    }
}
