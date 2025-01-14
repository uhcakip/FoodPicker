//
//  Tab+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/14.
//

import Foundation
import SwiftUI

extension Tab where Value: Hashable, Content: View, Label: View {
    init(
        symbol: SFSymbol,
        value: Value,
        @ViewBuilder content: () -> Content
    ) where Label == DefaultTabLabel {
        self.init(
            "",
            systemImage: symbol.rawValue,
            value: value,
            content: content
        )
    }
}
