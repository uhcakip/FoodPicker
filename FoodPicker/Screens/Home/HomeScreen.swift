//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by Yuna Chou on 2025/1/11.
//

import SwiftUI

struct HomeScreen: View {
    @ObserveInjection var inject
    @State private var selectedTab: TabItem = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { $0 }
        }
        .enableInjection()
    }
}

extension HomeScreen {
    enum TabItem: View, CaseIterable {
        case home, list

        var body: some View {
            content
                .tabItem {
                    Label(title, symbol: symbol)
                        .labelStyle(.iconOnly)
                }
        }

        var title: LocalizedStringKey {
            switch self {
            case .home:
                "Home"
            case .list:
                "List"
            }
        }

        var symbol: SFSymbol {
            switch self {
            case .home:
                    .houseFill
            case .list:
                    .list
            }
        }

        @ViewBuilder
        var content: some View {
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
