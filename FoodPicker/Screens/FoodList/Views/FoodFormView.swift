//
//  FoodFormView.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2024/12/27.
//

import SwiftUI

extension FoodListScreen {
    struct FoodFormView: View {
        @ObserveInjection var inject
        @Environment(\.dismiss) var dismiss
        @Environment(\.colorScheme) var colorScheme
        @State private var food: Food
        @FocusState private var field: Field?
        let save: (Food) -> Void
        private let actionLabel: Label<Text, Image>

        init(food: Food, save: @escaping (Food) -> Void) {
            _food = State(initialValue: food)
            self.save = save
            actionLabel = food.name.isEmpty ? Label("Add", symbol: .plus) : Label("Edit", symbol: .pencil)
        }

        private var isInputInvalid: Bool {
            food.name.isEmpty || food.emoji.count > 2
        }

        private var inValidMessage: String? {
            if food.name.isEmpty { return "Name is required" }
            if food.emoji.count > 2 { return "Emoji is too long" }
            return nil
        }

        var body: some View {
            NavigationStack {
                VStack {
                    HStack {
                        actionLabel
                            .font(.title.bold())
                            .foregroundStyle(.accent)
                            .hPush(to: .leading)

                        Button {
                            dismiss()
                        } label: {
                            Image(symbol: .xmarkFill)
                                .font(.system(size: 30))
                                .foregroundStyle(Color.secondary)
                        }
                    }
                    .padding([.horizontal, .top])

                    Form {
                        Field.name.buildString(value: $food.name, focusedField: $field)
                        Field.emoji.buildString(value: $food.emoji, focusedField: $field)
                        Field.calories.buildNumber(value: $food.calorie, focusedField: $field)
                        Field.carb.buildNumber(value: $food.carb, focusedField: $field)
                        Field.fat.buildNumber(value: $food.fat, focusedField: $field)
                        Field.protein.buildNumber(value: $food.protein, focusedField: $field)
                    }
                    .padding(.top, -16)

                    Button {
                        dismiss()
                        save(food)
                    } label: {
                        Text(inValidMessage ?? "Save")
                            .maxWidth()
                            .foregroundStyle(isInputInvalid ? .secondary : .primary)
                    }
                    .mainButtonStyle()
                    .padding()
                    .disabled(isInputInvalid)
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar(content: buildKeyboardToolbar)
            }
            .enableInjection()
        }
    }
}

// MARK: - Subviews
extension FoodListScreen.FoodFormView {
    private enum Field: Int {
        case name, emoji, calories, carb, fat, protein

        static let first: Self = .name
        static let last: Self = .protein

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

        func buildString(
            value: Binding<String>,
            focusedField: FocusState<Self?>.Binding
        ) -> some View {
            LabeledContent(title) {
                TextField(placeholder, text: value)
                    .focused(focusedField, equals: self)
                    .onSubmit {
                        value.wrappedValue = value.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
            }
        }

        func buildNumber(
            value: Binding<Double>,
            focusedField: FocusState<Self?>.Binding
        ) -> some View {
            LabeledContent(title) {
                HStack {
                    TextField("", value: value, format: .number.precision(.fractionLength(1)))
                        .keyboardType(.decimalPad)
                        .focused(focusedField, equals: self)
                    Text(suffix)
                }
            }
        }
    }

    private func buildKeyboardToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button(action: goPrevField) {
                Image(symbol: .chevronUp)
            }
            Button(action: goNextField) {
                Image(symbol: .chevronDown)
            }
        }
    }
}

// MARK: - Focus Handling
extension FoodListScreen.FoodFormView {
    private func goPrevField() {
        if let currentField = field {
            field = .init(
                rawValue: currentField == .first ? Field.last.rawValue : currentField.rawValue - 1
            )
        }
    }

    private func goNextField() {
        if let currentField = field {
            field = .init(
                rawValue: currentField == .last ? Field.first.rawValue : currentField.rawValue + 1
            )
        }
    }
}

// MARK: - Previews
#Preview {
    @Previewable @State var food = Food.examples.first!
    FoodListScreen.FoodFormView(food: food) { _ in }
}
