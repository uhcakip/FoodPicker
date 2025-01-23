//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/11.
//

import SwiftUI

struct HomeScreen: View {
    @ObserveInjection var inject
    @State private var selectedTab: TabItem.RawValue = {
        @AppStorageCodable(.selectedTab) var tab = TabItem.home.rawValue
        return tab
    }()
    @AppStorageCodable(.shouldUseDarkMode) private var shouldUseDarkMode = false

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases) {
                Tab(symbol: $0.symbol, value: $0.rawValue, content: $0.content)
            }
        }
        .preferredColorScheme(shouldUseDarkMode ? .dark : .light)
        .enableInjection()
    }
}

extension HomeScreen {
    enum TabItem: String, CaseIterable, Identifiable, Codable {
        case home, list, setting

        var id: Self { self }

        var symbol: SFSymbol {
            switch self {
            case .home:
                .houseFill
            case .list:
                .list
            case .setting:
                .gear
            }
        }

        @ViewBuilder
        func content() -> some View {
            switch self {
            case .home:
                FoodPickerScreen()
            case .list:
                FoodListScreen()
            case .setting:
                SettingScreen()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
