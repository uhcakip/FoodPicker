//
//  FoodDetailView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/8.
//

import SwiftUI

extension FoodListScreen {
    struct FoodDetailView: View {
        @Environment(\.dynamicTypeSize) private var dynamicTypeSize
        @State private var foodInfoHeight = 0.0
        let food: Food

        var body: some View {
            let shouldUseVStack = dynamicTypeSize.isAccessibilitySize || food.emoji.count > 1

            AnyLayout.vhStack(isVertical: shouldUseVStack, spacing: 30) {
                Text(food.emoji)
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .minimumScaleFactor(shouldUseVStack ? 1 : 0.5)

                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    buildNutritionGridRowView(title: "Calories", value: food.$cal.description)
                    buildNutritionGridRowView(title: "Protein", value: food.$protein.description)
                    buildNutritionGridRowView(title: "Fat", value: food.$fat.description)
                    buildNutritionGridRowView(title: "Carb", value: food.$carb.description)
                }
            }
            .padding()
            .maxWidth()
            .background(.secondGroupBg)
            .onGeometryChange(for: CGFloat.self) {
                $0.size.height
            } action: {
                foodInfoHeight = $0
            }
            .presentationDetents([.height(foodInfoHeight)])
        }

        private func buildNutritionGridRowView(title: String, value: String) -> some View {
            GridRow {
                Text(title).gridCellAnchor(.leading)
                Text(value).gridCellAnchor(.trailing)
            }
        }
    }
}

// MARK: - Previews
#Preview {
    @Previewable @State var food = Food.examples.first!
    FoodListScreen.FoodDetailView(food: food)
}
