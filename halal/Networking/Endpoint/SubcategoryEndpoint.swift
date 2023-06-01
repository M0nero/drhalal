//
//  SubcategoryEndpoint.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Alamofire

enum SubcategoryEndpoint {
    case getSubCategories(categoryId: Int)
}

extension SubcategoryEndpoint: Endpoint {
    var httpMethod: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getSubCategories(let categoryId): return "/subcategory/\(categoryId)"
        }
    }
    
    var params: [String: String] {
        switch self {
        default: return [:]
        }
    }
}
