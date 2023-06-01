//
//  ProductService.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

final class ProductService: ProductServiceProtocol {
    let controller: ProductApiController
    
    init(_ controller: ProductApiController) {
        self.controller = controller
    }
    
    func getProducts(page: Int, limit: Int, keyword: String = "") -> AnyPublisher<[Product], Error> {
        return controller.getProducts(page: page, limit: limit, keyword: keyword)
            .flatMap({ $0.toModel() })
            .eraseToAnyPublisher()
    }
    
    func getProductsInSubcategory(id: Int, page: Int, limit: Int) -> AnyPublisher<[Product], Error> {
        return controller.getProductsInSubcategory(id: id, page: page, limit: limit)
            .flatMap({ $0.toModel() })
            .eraseToAnyPublisher()
    }
    
    func getProduct(by cis: String) -> AnyPublisher<Product, Error> {
        return controller.getProduct(by: cis)
            .compactMap({ $0.toModel() })
            .eraseToAnyPublisher()
    }
    
    func getProduct(by id: Int) -> AnyPublisher<Product, Error> {
        return controller.getProduct(by: id)
            .compactMap({ $0.toModel() })
            .eraseToAnyPublisher()
    }
}
