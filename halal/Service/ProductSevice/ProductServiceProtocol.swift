//
//  ProductServiceProtocol.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

protocol ProductServiceProtocol {
    func getProducts(page: Int, limit: Int, keyword: String) -> AnyPublisher<[Product], Error>
    func getProductsInSubcategory(id: Int, page: Int, limit: Int) -> AnyPublisher<[Product], Error>
    func getProduct(by cis: String) -> AnyPublisher<Product, Error>
    func getProduct(by id: Int) -> AnyPublisher<Product, Error>
}
