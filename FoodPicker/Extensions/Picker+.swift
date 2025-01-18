//
//  Picker+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/16.
//

import SwiftUI

extension Picker where Label == SwiftUI.Label<Text, Image> {
    init(
        _ titleKey: LocalizedStringKey,
        symbol: SFSymbol,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) {
        self.init(titleKey, systemImage: symbol.rawValue, selection: selection, content: content)
    }
}
