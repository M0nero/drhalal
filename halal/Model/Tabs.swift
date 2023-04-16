//
//  SwiftUIView.swift
//  halal
//
//  Created by Damir Akbarov on 26.04.2022.
//

import SwiftUI

class Tabs: ObservableObject {
    
    @Published var selection: Tab
    
    init(initialSelection: Tab = .home) {
        self.selection = initialSelection
    }
}

enum Tab {
    case home, search, profile
}
