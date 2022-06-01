//
//  HomeViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 03.05.2022.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Хлеб и хлебобулочные изделия", color: .blue, img: "bread", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Выпечка", img: "bruh"),Subcategory(name: "Фаст-Фуд", img: "bruh")]),
        Category(name: "Молочная продукция", color: .cyan, img: "milk", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Мясная и колбасная продукция", color: .red, img: "eat", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Рыба и консервы", color: .green, img: "konservs", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Бакалея", color: .cyan, img: "coffee", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Напитки", color: .yellow, img: "drinks", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Кондитерские изделия", color: .systemPink, img: "sweets", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Соусы", color: .brown, img: "sous", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")]),
        Category(name: "Снеки и закуска", color: .orange, img: "chips", subcategories: [Subcategory(name: "Хлеб и булочки", img: "bruh"), Subcategory(name: "Хлеб и булочки", img: "bruh")])
    ]
}
