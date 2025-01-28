//
//  SettingScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/16.
//

import Inject
import SwiftUI

struct SettingScreen: View {
    @ObserveInjection var inject
    @AppStorageCodable(.shouldUseDarkMode) private var shouldUseDarkMode = false
    @AppStorageCodable(.selectedUnit) private var selectedUnit = UnitView.gram
    @AppStorageCodable(.selectedTab) private var selectedTab = HomeScreen.TabItem.home
    @State private var dialog: Dialog = .none

    private var shouldShowDialog: Binding<Bool> {
        Binding(
            get: { dialog != .none },
            set: { _ in dialog = .none }
        )
    }

    var body: some View {
        Form {
            Group {
                Section("Basic Settings") {
                    Toggle("Dark Mode", symbol: .moonFill, isOn: $shouldUseDarkMode)
                        .tint(.accent)

                    Picker("Unit", symbol: .numberSign, selection: $selectedUnit) {
                        ForEach(UnitView.allCases) { $0 }
                    }

                    Picker("Initial Tab", symbol: .squares, selection: $selectedTab) {
                        Text("Home")
                            .tag(HomeScreen.TabItem.home)
                        Text("List")
                            .tag(HomeScreen.TabItem.list)
                    }
                }

                Section("Danger Settings") {
                    ForEach(Dialog.allCases) { dialog in
                        Button(dialog.title) {
                            self.dialog = dialog
                        }
                        .foregroundStyle(Color(.label))
                    }
                }
            }
            .listRowInsets(.init(top: 2.5, leading: 10, bottom: 2.5, trailing: 10))
        }
        .confirmationDialog(
            dialog.title,
            isPresented: shouldShowDialog,
            titleVisibility: .visible,
            actions: {
                Button("OK", role: .destructive, action: dialog.action)
                Button("NO", role: .cancel) {}
            },
            message: {
                Text(dialog.message)
            }
        )
        .enableInjection()
    }
}

extension SettingScreen {
    private enum Dialog: String, CaseIterable, Identifiable {
        case resetSettings = "Reset Settings"
        case resetFoodList = "Reset Food List"
        case none

        static var allCases = [Self.resetSettings, .resetFoodList]

        var id: Self { self }

        var title: String { rawValue }

        var message: String {
            let result =
                switch self {
                case .resetSettings:
                    "This will reset settings such as colors and units."
                case .resetFoodList:
                    "This will reset the food list."
                case .none:
                    ""
                }
            return result + "\nThis action cannot be undone. \nAre you sure you want to proceed?"
        }

        func action() {
            switch self {
            case .resetSettings:
                let keys = [StorageKey.shouldUseDarkMode, .selectedUnit, .selectedTab]
                for key in keys {
                    UserDefaults.standard.removeObject(forKey: key.rawValue)
                }
            case .resetFoodList:
                UserDefaults.standard.removeObject(forKey: StorageKey.foodList.rawValue)
            case .none:
                return
            }
        }
    }
}

// MARK: - Previews
#Preview {
    SettingScreen()
}
