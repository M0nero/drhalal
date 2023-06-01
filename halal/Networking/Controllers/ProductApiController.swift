//
//  ProductApiController.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

final class ProductApiController {
    private let api: Request
    
    init(_ api: Request) {
        self.api = api
    }
    
    func getProduct(by id: Int) -> AnyPublisher<ProductDto, Error> {
        let endpoint = ProductEndpoint.getProduct(id: id)
        return api.send(endpoint)
    }
    
    func getProduct(by cis: String) -> AnyPublisher<ProductDto, Error> {
        let endpoint = ProductEndpoint.getProductByCis(cis: cis)
        return api.send(endpoint)
    }
    
    func getProducts(page: Int, limit: Int, keyword: String) -> AnyPublisher<ProductsWrapperDto, Error> {
        let endpoint = ProductEndpoint.getProducts(page: page, limit: limit)
        let payload = KeywordDto(keyword: keyword)
        return api.send(endpoint, payload: payload)
    }
    
    func getProductsInSubcategory(id: Int, page: Int, limit: Int) -> AnyPublisher<ProductsWrapperDto, Error> {
        let endpoint = ProductEndpoint.getProductsInSubCategory(id: id, page: page, limit: limit)
        return api.send(endpoint)
    }
}
