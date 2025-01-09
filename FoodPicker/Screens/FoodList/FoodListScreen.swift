//
//  FoodListScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/12/2.
//

import SwiftUI

struct FoodListScreen: View {
    @ObserveInjection var inject
    @Environment(\.editMode) var editMode
    @State private var foods = Food.examples
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
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .background(Color(.groupBg))
        .safeAreaInset(edge: .bottom, content: buildFloatingButton)
        .sheet(item: $sheet)
        .enableInjection()
    }
}

// MARK: - Subviews
private extension FoodListScreen {
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }

    var titleBar: some View {
        HStack {
            Label("Food List", symbol: .forkKnife)
                .font(.title.bold())
                .foregroundStyle(.accent)
                .fixedSize() // for dymatic font size (xxxLarge)

            EditButton()
                .hPush(to: .trailing)
                .buttonStyle(.bordered)
        }
        .padding()
    }

    var addButton: some View {
        Button {
            sheet = .addFood { foods.append($0) }
        } label: {
            Image(symbol: .plusFill)
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

    func buildFoodRow(data: Binding<Food>) -> some View {
        let food = data.wrappedValue
        return HStack {
            Text(food.name)
                .padding(.vertical, 5)
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

    func buildFloatingButton() -> some View {
        ZStack {
            addButton
                .opacity(isEditing ? 0 : 1)
                .scaleEffect(isEditing ? 0 : 1)
                .hPush(to: .trailing)

            removeSelectionsButton
                .opacity(isEditing ? 1 : 0)
                .offset(x: isEditing ? 0 : -60)
        }
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
