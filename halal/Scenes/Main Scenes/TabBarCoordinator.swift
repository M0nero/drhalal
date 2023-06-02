//
//  TabBarCoordinator.swift
//  halal
//
//  Created by Damir Akbarov on 26.05.2023.
//

import Foundation

class TabBarCoordinator: ObservableObject {

    // MARK: - Properties
    @Published var tab = Tab.home
    @Published var homeCoordinator: HomeCoordinator!
    @Published var searchCoordinator: SearchCoordinator!
    @Published var scannerCoordinator: ScannerCoordinator!

    // MARK: - Init
    init() {
        self.homeCoordinator = HomeCoordinator(parent: self)
        self.searchCoordinator = SearchCoordinator(parent: self)
        self.scannerCoordinator = ScannerCoordinator(parent: self)
    }
}
