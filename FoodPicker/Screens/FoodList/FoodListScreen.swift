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
    @State private var sheet: Sheet?

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
        .sheet(item: $sheet) { $0 }
        .enableInjection()
    }
}

private extension FoodListScreen {
    enum Sheet: View, Identifiable {
        case addFood(save: (Food) -> Void)
        case editFood(food: Binding<Food>)
        case foodDetail(food: Food)
        
        var id: UUID {
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
                FoodListScreen.FoodFormView(food: Food.new, save: save)
            case .editFood(let food):
                FoodListScreen.FoodFormView(food: food.wrappedValue) { food.wrappedValue = $0 }
            case .foodDetail(let food):
                FoodListScreen.FoodDetailView(food: food)
            }
        }
    }
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }

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
            sheet = .addFood { foods.append($0) }
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

    func buildFoodRow(data: Binding<Food>) -> some View {
        let food = data.wrappedValue
        return HStack {
            Text(food.name)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodIDs.insert(food.id)
                        return
                    }
                    sheet = .foodDetail(food: food)
                }

            Image(systemName: "pencil")
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
                .frame(maxWidth: .infinity, alignment: .trailing)

            removeSelectionsButton
                .opacity(isEditing ? 1 : 0)
                .offset(x: isEditing ? 0 : -60)
        }
        .animation(.easeInOut, value: isEditing)
    }
}

#Preview {
    FoodListScreen()
}

#Preview("FoodListScreen - isEditing") {
    FoodListScreen()
        .environment(\.editMode, .constant(.active))
}
