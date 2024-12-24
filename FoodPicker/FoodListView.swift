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
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            
            List($foods, editActions: .all, selection: $selectedFoodIDs) { $food in
                Text(food.name)
                    .padding(.vertical, 5)
            }
            .listStyle(.plain)
            .padding(.horizontal)
            
        }
        .scrollIndicators(.hidden)
        .background(Color(.groupBg))
        .safeAreaInset(edge: .bottom, content: buildFloatingButton)
        .sheet(isPresented: .constant(false)) {
            let food = foods[0]
            
            AnyLayout.vhStack(
                isVertical: dynamicTypeSize.isAccessibilitySize || food.image.count > 1,
                spacing: 30
            ) {
                Text(food.image)
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    buildNutritionGridRowView(title: "熱量", value: food.$calorie)
                    buildNutritionGridRowView(title: "蛋白質", value: food.$protein)
                    buildNutritionGridRowView(title: "脂肪", value: food.$fat)
                    buildNutritionGridRowView(title: "碳水", value: food.$carb)
                }
                .presentationDetents([.medium])
            }
            .padding()
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
                .transition(.move(edge: .leading).combined(with: .opacity))
                .id(isEditing)
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
