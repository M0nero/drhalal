//
//  Theme.swift
//  halal
//
//  Created by Damir Akbarov on 01.05.2023.
//
import SwiftUI

class Theme {
    
    static func navigationBarColors(background: UIColor?,
                                    titleColor: UIColor? = nil,
                                    tintColor: UIColor? = nil) {
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.shadowColor = nil
        navigationAppearance.shadowImage = UIImage(named: "shadow")
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
        UIScrollView.appearance().keyboardDismissMode = .onDrag
        UISearchBar.appearance().tintColor = titleColor
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }
    
    static func tabBarColors(titleColor: UIColor?, selectedColor: UIColor?) {
        let tabBarAppearance = UITabBarAppearance()

//        tabBarAppearance.backgroundColor = background
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = titleColor
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor ?? .black]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: selectedColor ?? .black]
        
        tabBarAppearance.stackedItemPositioning = .centered
        // Use this appearance when scrolling behind the TabView:
        UITabBar.appearance().standardAppearance = tabBarAppearance
        // Use this appearance when scrolled all the way up:
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
