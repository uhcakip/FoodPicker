//
//  FoodFormView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/12/27.
//

import SwiftUI

extension FoodListView {
    struct FoodFormView: View {
        @ObserveInjection var inject
        @Environment(\.dismiss) var dismiss
        @Environment(\.colorScheme) var colorScheme
        @State private var food: Food
        @FocusState private var field: Field?
        
        private let action: (text: String, image: String)
        
        init(food: Food) {
            _food = State(initialValue: food)
            action = food.name.isEmpty ? (text: "Add", image: "plus") : (text: "Edit", image: "pencil")
        }
        
        var body: some View {
            VStack {
                HStack {
                    Label(action.text, systemImage: action.image)
                        .font(.title.bold())
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(Color.secondary)
                    }
                }
                .padding([.horizontal, .top])
                
                Form {
                    Field.name.buildString(value: $food.name, focusedField: $field)
                    Field.emoji.buildString(value: $food.image, focusedField: $field)
                    Field.calories.buildNumber(value: $food.calorie, focusedField: $field)
                    Field.carb.buildNumber(value: $food.carb, focusedField: $field)
                    Field.fat.buildNumber(value: $food.fat, focusedField: $field)
                    Field.protein.buildNumber(value: $food.protein, focusedField: $field)
                }
                .padding(.top, -16)
                
                Button {
                    
                } label: {
                    Text(inValidMessage ?? "Save")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(isInputInvalid ? .secondary : Color.Catppuccin.buttonText)
                }
                .mainButtonStyle()
                .padding()
                .disabled(isInputInvalid)
            }
            .background(.groupBg)
            .multilineTextAlignment(.trailing)
            .font(.title3)
            .scrollDismissesKeyboard(.interactively)
            .enableInjection()
        }
    }
}

private extension FoodListView.FoodFormView {
    enum Field {
        case name, emoji, calories, carb, fat, protein
        
        var title: String {
            switch self {
            case .name: "Name"
            case .emoji: "Emoji"
            case .calories: "Calories"
            case .carb: "Carb"
            case .fat: "Fat"
            case .protein: "Protein"
            }
        }
        
        var placeholder: String {
            switch self {
            case .name: "Required"
            case .emoji: "Max 2 characters"
            default: ""
            }
        }
        
        var suffix: String {
            switch self {
            case .calories: "kcal"
            default: "g"
            }
        }
        
        var nextField: Field? {
            switch self {
            case .name: .emoji
            case .emoji: .calories
            case .calories: .carb
            case .carb: .fat
            case .fat: .protein
            case .protein: nil
            }
        }
        
        func buildString(
            value: Binding<String>,
            focusedField: FocusState<Field?>.Binding
        ) -> some View {
            LabeledContent(title) {
                TextField(placeholder, text: value)
                    .submitLabel(.next)
                    .focused(focusedField, equals: self)
                    .onSubmit {
                        value.wrappedValue = value.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)
                        if let nextField = nextField {
                            focusedField.wrappedValue = nextField
                        }
                    }
            }
        }
        
        func buildNumber(
            value: Binding<Double>,
            focusedField: FocusState<Field?>.Binding
        ) -> some View {
            LabeledContent(title) {
                HStack {
                    TextField("", value: value, format: .number.precision(.fractionLength(1)))
                        .keyboardType(.numbersAndPunctuation)
                        .focused(focusedField, equals: self)
                        .onSubmit {
                            if let nextField = nextField {
                                focusedField.wrappedValue = nextField
                            }
                        }
                    Text(suffix)
                }
            }
        }
    }
    
    private var isInputInvalid: Bool {
        food.name.isEmpty || food.image.count > 2
    }
    
    private var inValidMessage: String? {
        if food.name.isEmpty { return "Name is required" }
        if food.image.count > 2 { return "Emoji is too long" }
        return nil
    }
}

#Preview {
    @Previewable @State var food = Food.examples.first!
    FoodListView.FoodFormView(food: food)
}
