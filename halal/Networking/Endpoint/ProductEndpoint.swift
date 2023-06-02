//
//  ProductEndpoint.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Alamofire

enum ProductEndpoint {
    case getProducts(page: Int, limit: Int)
    case getProductsInSubCategory(id: Int, page: Int, limit: Int)
    case getProduct(id: Int)
    case getProductByCis(cis: String)
}

extension ProductEndpoint: Endpoint {
    var httpMethod: HTTPMethod {
        switch self {
        case .getProducts:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getProducts: return "/products"
        case .getProduct(let id): return "/products/\(id)"
        case .getProductByCis(let cis): return "/product/\(cis)"
        case .getProductsInSubCategory(let id, _, _): return "/products/subcategory/\(id)"
        }
    }
    
    var params: [String: String] {
        switch self {
        case .getProducts(let page, let limit):
            return ["limit": String(limit),
                    "page": String(page)]
        case .getProductsInSubCategory(_, let page, let limit):
            return ["limit": String(limit),
                    "page": String(page)]
        default:
            return [:]
        }
    }
}
