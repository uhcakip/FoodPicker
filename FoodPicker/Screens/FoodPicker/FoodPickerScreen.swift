//
//  FoodPickerScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/21.
//

import SwiftUI

struct FoodPickerScreen: View {
    @ObserveInjection var inject
    @State var selectedFood: Food?
    @State private var shouldShowFoodInfo = true
    @ScaledMetric private var foodImageSize = 200.0
    let foods = Food.examples

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 30) {
                    foodImage

                    Text("今天吃什麼?")
                        .font(.title.bold())

                    seletedFoodInfoView

                    Spacer()
                        .layoutPriority(1)

                    selectFoodButton

                    resetButton

                }
                .padding()
                .maxWidth()
                .frame(minHeight: proxy.size.height)
                .font(.title2.bold())
                .mainButtonStyle()
                .animation(.fpEase, value: selectedFood)
                .animation(.fpSpring, value: shouldShowFoodInfo)
            }
            .background(.secondBg)
        }
        .enableInjection()
    }
}

// MARK: - Subviews
private extension FoodPickerScreen {
    var foodImage: some View {
        Group {
            if let selectedFood {
                Text(selectedFood.emoji)
                    .font(.system(size: foodImageSize))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            } else {
                Image(.dinner)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(height: 250)
    }

    @ViewBuilder
    var seletedFoodInfoView: some View {
        if let selectedFood {
            // MARK: food name & info button
            HStack {
                Text(selectedFood.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.Catppuccin.peach)
                    .transition(.delayInsertionOpacity)

                Button {
                    withAnimation {
                        shouldShowFoodInfo.toggle()
                    }
                } label: {
                    Image(symbol: .infoFill)
                        .font(.title)
                        .foregroundStyle(
                            Color.Catppuccin.peach.opacity(0.5))
                }
                .buttonStyle(.plain)
            }
            .id(selectedFood.name)

            // MARK: food calorie
            Text("熱量 \(selectedFood.$calorie)")
                .font(.title2)

            // MARK: food nutrition
            VStack {
                if shouldShowFoodInfo {
                    Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                        GridRow {
                            Text("蛋白質")
                            Text("脂肪")
                            Text("碳水")
                        }
                        .frame(minWidth: 60)

                        Divider()
                            .gridCellUnsizedAxes(.horizontal)
                            .padding(.horizontal, -10)

                        GridRow {
                            Text("\(selectedFood.$protein)")
                            Text("\(selectedFood.$fat)")
                            Text("\(selectedFood.$carb)")
                        }
                    }
                    .font(.title3)
                    .padding()
                    .padding(.horizontal)
                    .roundedRectBackground()
                    .transition(.moveUpWithOpacity)
                }
            }
            .maxWidth()
            .clipped()
        }
    }

    var selectFoodButton: some View {
        Button {
            selectedFood = foods.filter {
                $0 != selectedFood
            }.randomElement()
        } label: {
            Text(selectedFood == nil ? "告訴我" : "換一個")
                .frame(width: 200)
                .transformEffect(.identity)
        }
        .padding(.bottom, -15)
    }

    var resetButton: some View {
        Button {
            selectedFood = nil
            shouldShowFoodInfo = false
        } label: {
            Text("重置")
                .frame(width: 200)
        }
        .buttonStyle(.bordered)
    }
}

// MARK: - Previews
#Preview {
    FoodPickerScreen(selectedFood: .examples.first!)
}
