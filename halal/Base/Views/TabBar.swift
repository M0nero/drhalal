//
//  ContentView.swift
//  halal
//
//  Created by Damir Akbarov on 11.04.2022.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var tabs = Tabs(initialSelection: .home)
    @StateObject var products = ProductsViewModel()
    @StateObject var categories = CategoriesViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $tabs.selection) {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(Tab.search)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            //tabBarAppearance.configureWithTransparentBackground()
            tabBarAppearance.backgroundColor = colorScheme == .light ? UIColor(named: "color") : .none
            tabBarAppearance.backgroundEffect = colorScheme == .light ? nil : UIBlurEffect(style: .systemThinMaterial)

            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "titleColor")
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "titleColor") ?? .black]

            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "selectedColor")
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "selectedColor") ?? .black]

            tabBarAppearance.stackedItemPositioning = .centered
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = tabBarAppearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            self.products.fetchData()
        }
        .onChange(of: colorScheme){ [colorScheme] newColor in
            UITabBar.appearance().standardAppearance.backgroundEffect = newColor == .light ? nil : UIBlurEffect(style: .systemThinMaterial)
            UITabBar.appearance().standardAppearance.backgroundColor = newColor == .light ? UIColor(named: "color") : nil
            
        }
        .environmentObject(tabs)
        .environmentObject(products)
        .environmentObject(categories)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
