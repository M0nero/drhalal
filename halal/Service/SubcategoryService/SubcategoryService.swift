//
//  SubcategoryService.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

final class SubcategoryService: SubcategoryServiceProtocol {
    let controller: SubcategoryApiController
    
    init(_ controller: SubcategoryApiController) {
        self.controller = controller
    }
    
    func getSubcategories(by categoryId: Int) -> AnyPublisher<[Subcategory], Error> {
        return controller.getSubcategories(by: categoryId)
            .flatMap({ $0.toModel() })
            .eraseToAnyPublisher()
    }
}
