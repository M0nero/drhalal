//
//  ProductDto.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import Foundation

struct ProductDto: Decodable {
    var id: Int?
    var halalStatus: Int?
    var description: String?
    var img: String?
    var name: String?
    var subcategoryId: Int?
    var cis: String?
    
    func toModel() -> Product? {
        guard let id = id,
              let halalStatus = halalStatus,
              let description = description,
              let img = img,
              let name = name,
              let subcategoryId = subcategoryId else { return nil }
        
        let model = Product(id: id,
                            halalStatus: halalStatus,
                            description: description,
                            img: img,
                            name: name,
                            subcategoryId: subcategoryId,
                            cis: cis)
        return model
    }
}

extension ProductDto {
    private enum CodingKeys: String, CodingKey {
        case id
        case halalStatus = "halal_status"
        case description = "product_description"
        case img = "product_img"
        case name = "product_name"
        case subcategoryId = "subcategory_id"
        case cis = "sis"
    }
}
