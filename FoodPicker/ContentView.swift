//
//  ContentView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/11/21.
//

import SwiftUI

struct ContentView: View {
    let foods = Food.examples
    @State private var selectedFood: Food?
    @State private var showFoodInfo = true
    @ScaledMetric private var foodImageSize = 200.0

    var body: some View {
        VStack(spacing: 30) {
            Group {
                if let selectedFood {
                    Text(selectedFood.image)
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

            Text("今天吃什麼?")
                .bold()

            if let selectedFood {
                // MARK: - Selected food name & info button
                HStack {
                    Text(selectedFood.name)
                        .foregroundStyle(Color.Catppuccin.peach)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.animation(
                                    .easeInOut(duration: 0.5).delay(0.2)
                                ),
                                removal: .opacity.animation(
                                    .easeInOut(duration: 0.4)
                                )
                            )
                        )

                    Button {
                        withAnimation {
                            showFoodInfo.toggle()
                        }
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.title)
                            .foregroundStyle(
                                Color.Catppuccin.peach.opacity(0.5))
                    }
                    .buttonStyle(.plain)
                }
                .id(selectedFood.name)

                // MARK: - Selected food calorie
                Text("熱量 \(Int(selectedFood.calorie)) 大卡")
                    .font(.title2)

                // MARK: - Selected food info
                if showFoodInfo {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .overlay {
                            HStack {
                                Group {
                                    VStack(spacing: 20) {
                                        Text("蛋白質")
                                        Text("\(selectedFood.protein.formatted()) g")
                                    }

                                    VStack(spacing: 20) {
                                        Text("脂肪")
                                        Text("\(selectedFood.fat.formatted()) g")
                                    }

                                    VStack(spacing: 20) {
                                        Text("碳水")
                                        Text("\(selectedFood.carb.formatted()) g")
                                    }
                                }
                                .frame(width: 80)
                            }
                        }
                        .font(.title3)
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal, 40)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .top).combined(
                                    with: .opacity),
                                removal: .move(edge: .top).combined(
                                    with: .opacity)
                            )
                        )
                }
            }

            if !showFoodInfo {
                Spacer()
            }

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

            Button {
                selectedFood = nil
                showFoodInfo = false
            } label: {
                Text("重置")
                    .frame(width: 200)
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .font(.title)
        .background(Color(.secondarySystemBackground))
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .animation(.easeInOut(duration: 0.4), value: selectedFood)
    }
}

extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

#Preview {
    ContentView(selectedFood: .examples.first!)
}
