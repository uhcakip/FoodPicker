//
//  View+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/25.
//

import SwiftUI

extension View {
    func mainButtonStyle() -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    }

    func roundedRectBackground(
        radius: CGFloat = 8,
        fill: some ShapeStyle = Color.mainBg
    ) -> some View {
        background(RoundedRectangle(cornerRadius: radius).foregroundStyle(fill))
    }
}
