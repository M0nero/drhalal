//
//  SubcategoryApiController.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

final class SubcategoryApiController {
    private let api: Request
    
    init(_ api: Request) {
        self.api = api
    }
    
    func getSubcategories(by categoryId: Int) -> AnyPublisher<SubcategoryWrapperDto, Error> {
        let endpoint = SubcategoryEndpoint.getSubCategories(categoryId: categoryId)
        return api.send(endpoint)
    }
}
