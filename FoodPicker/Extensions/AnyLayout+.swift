//
//  AnyLayout+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/12/10.
//

import SwiftUI

extension AnyLayout {
    static func vhStack(
        isVertical: Bool,
        spacing: CGFloat,
        @ViewBuilder content: () -> some View
    ) -> some View {
        let layout = isVertical ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        //return layout { content() }
        return layout(content)
    }
}
