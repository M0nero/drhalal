//
//  SubcategoryServiceProtocol.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation
import Combine

protocol SubcategoryServiceProtocol {
    func getSubcategories(by categoryId: Int) -> AnyPublisher<[Subcategory], Error>
}
