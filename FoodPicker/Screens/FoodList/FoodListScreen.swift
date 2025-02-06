//
//  FoodListScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/12/2.
//

import SwiftUI

struct FoodListScreen: View {
    @ObserveInjection var inject
    @State private var editMode: EditMode = .inactive
    @AppStorageCodable(.foodList) private var foods = Food.examples
    @State private var selectedFoodIDs = Set<Food.ID>()
    @State private var sheet: FoodSheetView?

    var body: some View {
        VStack(alignment: .leading) {
            titleBar

            List(
                $foods,
                editActions: .all,
                selection: $selectedFoodIDs,
                rowContent: buildFoodRow
            )
            .contentMargins(.top, 0)
        }
        .environment(\.editMode, $editMode)
        .scrollIndicators(.hidden)
        .background(.groupBg)
        .safeAreaInset(edge: .bottom, content: buildFloatingButton)
        .sheet(item: $sheet)
        .enableInjection()
    }
}

// MARK: - Subviews
extension FoodListScreen {
    private var isEditing: Bool {
        editMode.isEditing
    }

    private var titleBar: some View {
        HStack {
            Label("Food List", symbol: .forkKnife)
                .font(.title.bold())
                .foregroundStyle(.accent)
                .fixedSize()  // for dynamic font size (xxxLarge)

            EditButton()
                .buttonStyle(.bordered)
                .hPush(to: .trailing)

            addButton
        }
        .padding()
    }

    private var addButton: some View {
        Button {
            sheet = .addFood { foods.append($0) }
        } label: {
            Image(symbol: .plusFill)
                .font(.system(size: 35))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .accent.gradient)
        }
    }

    private var removeSelectionsButton: some View {
        Button {
            foods = foods.filter { !selectedFoodIDs.contains($0.id) }
        } label: {
            Text("Remove selections")
                .font(.title2.bold())
                .padding(.horizontal, 50)
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 8))
    }

    private func buildFoodRow(data: Binding<Food>) -> some View {
        let food = data.wrappedValue
        return HStack {
            Text(food.name)
                .font(.title3)
                .padding(.vertical, 10)
                .hPush(to: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodIDs.insert(food.id)
                        return
                    }
                    sheet = .foodDetail(food: food)
                }

            Image(symbol: .pencil)
                .font(.title3.bold())
                .foregroundStyle(.accent)
                .offset(x: isEditing ? 0 : 60)
                .animation(.easeInOut(duration: 0.3), value: isEditing)
                .onTapGesture {
                    sheet = .editFood(food: data)
                }
        }
    }

    private func buildFloatingButton() -> some View {
        removeSelectionsButton
            .padding(.bottom, 10)
            .opacity(isEditing ? 1 : 0)
            .offset(x: isEditing ? 0 : -60)
            .animation(.easeInOut, value: isEditing)
    }
}

// MARK: - Previews
#Preview {
    FoodListScreen()
}

#Preview("FoodListScreen - isEditing") {
    FoodListScreen()
        .environment(\.editMode, .constant(.active))
}
