//
//  SearchCoordinator.swift
//  halal
//
//  Created by Damir Akbarov on 27.05.2023.
//

import SwiftUI

class SearchCoordinator: ObservableObject, Identifiable, ListCoordinatorProtocol {

    // MARK: - Properties
    @Published var viewModel: SearchViewModel!
    @Published var productsListViewModel: ProductsListViewModel!
    @Published var productViewModel: ProductViewModel?

    private unowned let parent: TabBarCoordinator

    // MARK: - Init
    init(parent: TabBarCoordinator) {
        self.parent = parent
        self.viewModel = .init(coordinator: self)
        self.productsListViewModel = .init(.search,
                                           coordinator: self)
    }
    
    func openProduct(_ product: Product) {
        self.productViewModel = .init(product: product,
                                      coordinator: self)
    }
}
