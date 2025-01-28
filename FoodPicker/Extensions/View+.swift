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

    func roundedRectBackground(radius: CGFloat = 8, fill: some ShapeStyle = .mainBg) -> some View {
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
    }

    func sheet(item: Binding<(some View & Identifiable)?>) -> some View {
        sheet(item: item) { $0 }
    }

    /// Expands the view to the full width of its container and aligns the content horizontally according to the
    /// specified alignment.
    ///
    /// - Parameter alignment: The horizontal alignment for the content. Options are `.leading`, `.center`, and
    ///   `.trailing`.
    /// - Returns: A view that takes up the full width of its container and aligns its content according to the
    ///   specified alignment.
    /// - Tag: hPush
    func hPush(to alignment: TextAlignment) -> some View {
        switch alignment {
        case .leading:
            frame(maxWidth: .infinity, alignment: .leading)
        case .center:
            frame(maxWidth: .infinity)
        case .trailing:
            frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    /// This is a shortcut for calling [`hPush(to:)`](x-source-tag://hPush) with `.center` alignment.
    func maxWidth() -> some View {
        hPush(to: .center)
    }
}
