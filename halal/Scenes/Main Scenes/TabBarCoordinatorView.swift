//
//  TabBarCoordinatorView.swift
//  halal
//
//  Created by Damir Akbarov on 11.04.2023.
//

import SwiftUI

enum Tab {
    case home, search, scanner, profile
}

struct TabBarCoordinatorView: View {
    
    @ObservedObject var coordinator: TabBarCoordinator
    
    var body: some View {
        TabView(selection: $coordinator.tab) {
            SearchCoordinatorView(coordinator: coordinator.searchCoordinator)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Поиск")
                }
                .tag(Tab.search)
            
            HomeCoordinatorView(coordinator: coordinator.homeCoordinator)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
                .tag(Tab.home)
            
            ScannerViewCoordinator(coordinator: coordinator.scannerCoordinator)
                .tabItem {
                    Image(systemName: "barcode.viewfinder")
                    Text("Сканер")
                }.tag(Tab.scanner)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
                .tag(Tab.profile)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIColor(named: "color")
            tabBarAppearance.backgroundEffect = nil

            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "titleColor")
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(named: "titleColor") ?? .black]

            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "selectedColor")
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(named: "selectedColor") ?? .black]

            tabBarAppearance.stackedItemPositioning = .centered
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = tabBarAppearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
