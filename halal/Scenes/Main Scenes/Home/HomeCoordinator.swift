//
//  HomeCoordinator.swift
//  halal
//
//  Created by Damir Akbarov on 26.05.2023.
//

import SwiftUI

protocol ListCoordinatorProtocol: AnyObject {
    func openProduct(_ product: Product)
}

final class HomeCoordinator: ObservableObject, Identifiable, ListCoordinatorProtocol {

    // MARK: - Properties
    @Published var viewModel: HomeViewModel!
    @Published var subcategoriesViewModel: SubcategoriesViewModel?
    @Published var productsListViewModel: ProductsListViewModel?
    @Published var productViewModel: ProductViewModel?

    private unowned let parent: TabBarCoordinator

    // MARK: - Init
    init(parent: TabBarCoordinator) {
        self.parent = parent
        self.viewModel = .init(coordinator: self)
    }

    // MARK: - Public methods
    func openSubcategories(_ category: Category) {
        self.subcategoriesViewModel = .init(categoryId: category.id,
                                            categoryName: category.name,
                                            coordinator: self)
    }
    
    func openProductsList(_ subcategory: Subcategory) {
        self.productsListViewModel = .init(.subcategory,
                                           subcategoryId: subcategory.id,
                                           coordinator: self)
    }
    
    func openProduct(_ product: Product) {
        self.productViewModel = .init(product: product,
                                      coordinator: self)
    }
}
