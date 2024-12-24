//
//  View+.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/25.
//

import SwiftUI

extension View {
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(shape)
            .controlSize(.large)
    }

    func roundedRectBackground(
        radius: CGFloat = 8,
        fill: some ShapeStyle = .mainBg
    ) -> some View {
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
    }
}
