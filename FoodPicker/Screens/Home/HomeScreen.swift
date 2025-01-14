//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/11.
//

import SwiftUI

struct HomeScreen: View {
    @ObserveInjection var inject
    @State private var selectedTab: TabItem.RawValue = TabItem.home.rawValue

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases) {
                Tab(symbol: $0.symbol, value: $0.rawValue, content: $0.content)
            }
        }
        .enableInjection()
    }
}

extension HomeScreen {
    enum TabItem: String, CaseIterable {
        case home, list

        var symbol: SFSymbol {
            switch self {
            case .home:
                .houseFill
            case .list:
                .list
            }
        }

        @ViewBuilder
        func content() -> some View {
            switch self {
            case .home:
                FoodPickerScreen()
            case .list:
                FoodListScreen()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
