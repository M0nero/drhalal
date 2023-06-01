//
//  SubcategoryWrapperDto.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

struct SubcategoryWrapperDto: Decodable {
    var status: String?
    var results: Int?
    var subcategories: [SubcategoryDto]?
    
    func toModel() -> AnyPublisher<[Subcategory], Error> {
        Deferred {
            Future { promise in
                guard let subcategories = subcategories?.compactMap({ $0.toModel() }) else {
                    promise(.failure(ParseError.convertDtoError))
                    return
                }
                promise(.success(subcategories))
            }
        }
        .eraseToAnyPublisher()
    }
}
