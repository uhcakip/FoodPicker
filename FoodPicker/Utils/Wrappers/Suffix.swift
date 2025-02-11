//
//  Suffix.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/2/10.
//

import Foundation

@propertyWrapper
struct Suffix<Unit: FoodUnit & Equatable>: Equatable {
    var wrappedValue: Double
    var unit: Unit
    private var store: UserDefaults = .standard

    init(wrappedValue: Double, _ unit: Unit, store: UserDefaults = .standard) {
        self.wrappedValue = wrappedValue
        self.unit = unit
        self.store = store
    }

    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }

    var convertedValue: Double {
        converted.value
    }

    var description: String {
        converted.formatted(
            .measurement(
                width: .abbreviated,
                usage: .asProvided,
                numberFormatStyle: .number.precision(.fractionLength(0...1))
            )
        )
    }

    private var converted: Measurement<Unit.T> {
        let selectedUnit = Unit.getSelection()
        return Measurement(value: wrappedValue, unit: unit.dimension).converted(to: selectedUnit.dimension)
    }
}

extension Suffix: Codable {
    private enum CodingKeys: CodingKey {
        case wrappedValue
        case unit
    }

    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Suffix<Unit>.CodingKeys> =
            try decoder.container(keyedBy: Suffix<Unit>.CodingKeys.self)

        self.wrappedValue = try container.decode(Double.self, forKey: Suffix<Unit>.CodingKeys.wrappedValue)
        self.unit = try container.decode(Unit.self, forKey: Suffix<Unit>.CodingKeys.unit)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: Suffix<Unit>.CodingKeys.self)

        try container.encode(self.wrappedValue, forKey: Suffix.CodingKeys.wrappedValue)
        try container.encode(self.unit, forKey: Suffix.CodingKeys.unit)
    }
}
