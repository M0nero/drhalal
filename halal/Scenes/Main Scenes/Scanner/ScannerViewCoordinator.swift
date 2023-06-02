//
//  ScannerViewCoordinator.swift
//  halal
//
//  Created by Damir Akbarov on 02.06.2023.
//

import SwiftUI

struct ScannerViewCoordinator: View {
    
    @ObservedObject var coordinator: ScannerCoordinator
    
    init(coordinator: ScannerCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            getScanner(coordinator.viewModel)
        }
    }
                
    @ViewBuilder
    private func getScanner(_ viewModel: ScannerViewModel) -> some View {
        ScannerView(
            viewModel: viewModel,
            productModifier: FullScreenCoverModifier(item: $coordinator.productViewModel) { viewModel in
                ProductView(viewModel: viewModel)
                    .onReceive(viewModel.objectWillChange) { _ in
                        coordinator.resetScanner()
                    }
            }
        )
    }
}
