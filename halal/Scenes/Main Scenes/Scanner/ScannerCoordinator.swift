//
//  ScannerCoordinator.swift
//  halal
//
//  Created by Damir Akbarov on 02.06.2023.
//

import SwiftUI

final class ScannerCoordinator: ObservableObject, Identifiable, ListCoordinatorProtocol {

    // MARK: - Properties
    @Published var viewModel: ScannerViewModel!
    @Published var productViewModel: ProductViewModel?

    private unowned let parent: TabBarCoordinator

    // MARK: - Init
    init(parent: TabBarCoordinator) {
        self.parent = parent
        self.viewModel = .init(coordinator: self)
    }

    // MARK: - Public methods
    func openProduct(_ product: Product) {
        self.productViewModel = .init(product: product,
                                      coordinator: self)
    }
    
    func closeProduct() {
        self.productViewModel = nil
    }
    
    func resetScanner() {
        self.viewModel.scanDelegate.scannedCode = nil
    }
}
