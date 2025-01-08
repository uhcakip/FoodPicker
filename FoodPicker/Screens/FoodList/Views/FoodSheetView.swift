//
//  FoodSheetView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/8.
//

import SwiftUI

extension FoodListScreen {
    enum FoodSheetView: View, Identifiable {
        case addFood(save: (Food) -> Void)
        case editFood(food: Binding<Food>)
        case foodDetail(food: Food)

        var id: Food.ID {
            switch self {
            case .addFood:
                UUID()
            case .editFood(let food):
                food.id
            case .foodDetail(let food):
                food.id
            }
        }

        var body: some View {
            switch self {
            case .addFood(let save):
                FoodFormView(food: Food.new, save: save)
            case .editFood(let food):
                FoodFormView(food: food.wrappedValue) { food.wrappedValue = $0 }
            case .foodDetail(let food):
                FoodDetailView(food: food)
            }
        }
    }
}

#Preview("FoodSheetView - editFood") {
    @Previewable @State var food = Food.examples.first!
    FoodListScreen.FoodSheetView.editFood(food: .constant(food))
}

#Preview("FoodSheetView - addFood") {
    FoodListScreen.FoodSheetView.addFood { _ in }
}

#Preview("FoodSheetView - foodDetail") {
    @Previewable @State var food = Food.examples.first!
    FoodListScreen.FoodSheetView.foodDetail(food: food)
}
