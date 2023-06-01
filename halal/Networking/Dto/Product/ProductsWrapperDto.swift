//
//  ProductsWrapperDto.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

struct ProductsWrapperDto: Decodable {
    var status: String?
    var results: Int?
    var products: [ProductDto]?
    
    func toModel() -> AnyPublisher<[Product], Error> {
        Deferred {
            Future { promise in
                guard let products = products?.compactMap({ $0.toModel() }) else {
                    promise(.failure(ParseError.convertDtoError))
                    return
                }
                promise(.success(products))
            }
        }
        .eraseToAnyPublisher()
    }
}
