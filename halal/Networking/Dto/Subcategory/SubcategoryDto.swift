//
//  SubcategoryDto.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation

struct SubcategoryDto: Decodable {
    var id: Int?
    var categoryId: Int?
    var img: String?
    var name: String?
    
    func toModel() -> Subcategory? {
        guard let id = id,
              let name = name,
              let categoryId = categoryId else { return nil }
        
        let model = Subcategory(id: id, categoryId: categoryId, name: name, img: img)
        return model
    }
}

extension SubcategoryDto {
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case img = "img_url"
        case name
    }
}
