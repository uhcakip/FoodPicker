//
//  FoodListView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/12/2.
//

import SwiftUI

struct FoodListView: View {
    @ObserveInjection var inject
    @Environment(\.editMode) var editMode
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var foods = Food.examples
    @State private var selectedFoodIDs = Set<Food.ID>()
    @State private var tappedFood: Food?
    @State private var foodInfoHeight = 0.0
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            
            List($foods, editActions: .all, selection: $selectedFoodIDs) { $food in
                HStack {
                    Text(food.name)
                        .padding(.vertical, 5)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .leading
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if !isEditing {
                                tappedFood = food
                            }
                        }
                    
                    Image(systemName: "pencil")
                        .font(.title3.bold())
                        .foregroundStyle(.accent)
                        .offset(x: isEditing ? 0 : 60)
                        .animation(.easeInOut(duration: 0.3), value: isEditing)
                }
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .background(Color(.groupBg))
        .safeAreaInset(edge: .bottom, content: buildFloatingButton)
        .sheet(item: $tappedFood) { food in
            let shouldUseVStack = dynamicTypeSize.isAccessibilitySize || food.image.count > 1
            
            AnyLayout.vhStack(isVertical: shouldUseVStack, spacing: 30) {
                Text(food.image)
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .minimumScaleFactor(shouldUseVStack ? 1 : 0.5)
                
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    buildNutritionGridRowView(title: "熱量", value: food.$calorie)
                    buildNutritionGridRowView(title: "蛋白質", value: food.$protein)
                    buildNutritionGridRowView(title: "脂肪", value: food.$fat)
                    buildNutritionGridRowView(title: "碳水", value: food.$carb)
                }
            }
            .padding()
            .onGeometryChange(for: CGFloat.self) {
                $0.size.height
            } action: {
                foodInfoHeight = $0
            }
            .presentationDetents([.height(foodInfoHeight)])
        }
        .enableInjection()
    }
}

private extension FoodListView {
    var titleBar: some View {
        HStack {
            Label("Food List", systemImage: "fork.knife")
                .font(.title.bold())
                .foregroundStyle(.accent)
                .fixedSize() // for dymatic font size (xxxLarge)
            
            EditButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.bordered)
        }
        .padding()
    }
    
    var addButton: some View {
        Button {
            
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .accent.gradient)
        }
    }
    
    var removeSelectionsButton: some View {
        Button {
            foods = foods.filter { !selectedFoodIDs.contains($0.id) }
        } label: {
            Text("Remove selections")
                .font(.title2.bold())
                .padding(.horizontal, 50)
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 8))
    }
    
    func buildFloatingButton() -> some View {
        ZStack {
            addButton
                .opacity(isEditing ? 0 : 1)
                .scaleEffect(isEditing ? 0 : 1)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            removeSelectionsButton
                .opacity(isEditing ? 1 : 0)
                .offset(x: isEditing ? 0 : -60)
        }
        .animation(.easeInOut, value: isEditing)
    }
    
    func buildNutritionGridRowView(title: String, value: String) -> some View {
        GridRow {
            Text(title).gridCellAnchor(.leading)
            Text(value).gridCellAnchor(.trailing)
        }
    }
}

#Preview {
    FoodListView()
}

#Preview("FoodListViewEditing") {
    FoodListView()
        .environment(\.editMode, .constant(.active))
}
