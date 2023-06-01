//
//  HomeViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 03.05.2023.
//

import Foundation

final class HomeViewModel: ViewModel {
    // MARK: - Properties
    private unowned let coordinator: HomeCoordinator
    
    @Published var categories: [Category] = [
        Category(id: 1, color: .blue, name: "Хлеб и хлебобулочные изделия", img: "bread"),
        Category(id: 2, color: .cyan, name: "Молочная продукция", img: "milk"),
        Category(id: 3, color: .red, name: "Мясная и колбасная продукция", img: "eat"),
        Category(id: 4, color: .green, name: "Рыба и консервы", img: "konservs"),
        Category(id: 5, color: .cyan, name: "Бакалея", img: "coffee"),
        Category(id: 6, color: .yellow, name: "Напитки", img: "drinks"),
        Category(id: 7, color: .systemPink, name: "Кондитерские изделия", img: "sweets"),
        Category(id: 8, color: .brown, name: "Соусы", img: "sous"),
        Category(id: 9, color: .orange, name: "Снеки и закуска", img: "chips")
    ]
    
    // MARK: - Init
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Public methods
    func open(_ category: Category) {
        self.coordinator.openSubcategories(category)
    }
}
