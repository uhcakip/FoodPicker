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

                    Text("What to eat today?")
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
extension FoodPickerScreen {
    private var foodImage: some View {
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
    private var seletedFoodInfoView: some View {
        if let selectedFood {
            // MARK: food name & info button
            HStack {
                Text(selectedFood.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.accent)
                    .transition(.delayInsertionOpacity)

                Button {
                    withAnimation {
                        shouldShowFoodInfo.toggle()
                    }
                } label: {
                    Image(symbol: .infoFill)
                        .font(.title)
                        .foregroundStyle(.white, .accent)
                }
                .buttonStyle(.plain)
            }
            .id(selectedFood.name)

            // MARK: food calorie
            Text("Calories \(selectedFood.$calorie)")
                .font(.title2)

            // MARK: food nutrition
            VStack {
                if shouldShowFoodInfo {
                    Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                        GridRow {
                            Text("Protein")
                            Text("Fat")
                            Text("Carb")
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

    private var selectFoodButton: some View {
        Button {
            selectedFood =
                foods.filter {
                    $0 != selectedFood
                }
                .randomElement()
        } label: {
            Text(selectedFood == nil ? "Tell me" : "Change")
                .frame(width: 200)
                .transformEffect(.identity)
        }
        .padding(.bottom, -15)
    }

    private var resetButton: some View {
        Button {
            selectedFood = nil
            shouldShowFoodInfo = false
        } label: {
            Text("Reset")
                .frame(width: 200)
        }
        .buttonStyle(.bordered)
    }
}

// MARK: - Previews
#Preview {
    FoodPickerScreen(selectedFood: .examples.first!)
}
