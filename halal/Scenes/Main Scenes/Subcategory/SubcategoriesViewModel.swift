//
//  SubcategoriesViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 23.05.2023.
//

import SwiftUI
import Foundation

final class SubcategoriesViewModel: ViewModel {
    // MARK: - Services
    @Inject private var service: SubcategoryServiceProtocol
    
    // MARK: - Properties
    @Published var categoryId: Int
    @Published var categoryName: String
    @Published var subcategories: [Subcategory] = []
    @Published var errorMessage = ""
    
    private unowned let coordinator: HomeCoordinator
    
    // MARK: - Init
    init(categoryId: Int, categoryName: String, coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.categoryId = categoryId
        self.categoryName = categoryName
        super.init()
        getData(categoryId: categoryId)
    }
    
    // MARK: - Public methods
    func open(_ subcategory: Subcategory) {
        coordinator.openProductsList(subcategory)
    }
    
    // MARK: - Private methods
    private func getData(categoryId: Int) {
        service.getSubcategories(by: categoryId)
            .sink(receiveCompletion: { [weak self] completion in
                guard let error = try? completion.error().localizedDescription else { return }
                DispatchQueue.main.async {
                    self?.errorMessage = error
                }
            },
                  receiveValue: { [weak self] subcategories in
                self?.subcategories = subcategories
            })
            .store(in: &subscriptions)
    }
}
