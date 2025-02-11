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
                        Field.calories.buildNumber(value: $food.$cal, focusedField: $field)
                        Field.protein.buildNumber(value: $food.$protein, focusedField: $field)
                        Field.fat.buildNumber(value: $food.$fat, focusedField: $field)
                        Field.carb.buildNumber(value: $food.$carb, focusedField: $field)
                    }
                    .padding(.top, -16)

                    Button {
                        dismiss()
                        save(food)
                    } label: {
                        Text(inValidMessage ?? "Save")
                            .font(.title2.bold())
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
        case name, emoji, calories, protein, fat, carb

        static let first: Self = .name
        static let last: Self = .carb

        var title: String {
            switch self {
            case .name: "Name"
            case .emoji: "Emoji"
            case .calories: "Calories"
            case .protein: "Protein"
            case .fat: "Fat"
            case .carb: "Carb"
            }
        }

        var placeholder: String {
            switch self {
            case .name: "Required"
            case .emoji: "Max 2 characters"
            default: ""
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
                    .keyboardType(self == .emoji ? .emoji : .default)
            }
        }

        func buildNumber(
            value: Binding<Suffix<some FoodUnit>>,
            focusedField: FocusState<Self?>.Binding
        ) -> some View {
            let stringValue = Binding {
                NumberFormatter.foodNutrition.string(from: NSNumber(value: value.wrappedValue.convertedValue)) ?? ""
            } set: { newValue in
                let trimmed = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                if let number = NumberFormatter.foodNutrition.number(from: trimmed)?.doubleValue {
                    value.wrappedValue.wrappedValue = number
                } else if trimmed.isEmpty {
                    value.wrappedValue.wrappedValue = 0
                }
            }

            return LabeledContent(title) {
                HStack {
                    TextField("0.0", text: stringValue)
                        .keyboardType(.decimalPad)
                        .focused(focusedField, equals: self)

                    Text(type(of: value.wrappedValue.unit).getSelection().localizedSymbol)
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
