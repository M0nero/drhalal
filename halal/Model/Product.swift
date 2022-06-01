//
//  Product.swift
//  halal
//
//  Created by Damir Akbarov on 27.04.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var halalStatus: Int8
    var description: String
    var img: String
    var name: String
    var subcategoryId: Int16
    var keywordsForLookup: [String]{
        let name = self.name.replacingOccurrences(of: "[\"\",]", with: "", options: .regularExpression, range: nil)
        return [name.trimmingCharacters(in: .whitespaces).generateStringSequence()].flatMap{ $0 }
    }
    
    enum CodingKeys: String, CodingKey {
        case halalStatus = "halal_status"
        case description = "product_description"
        case img = "product_img"
        case name = "product_name"
        case subcategoryId = "subcategory_id"
    }
}

extension String {
    func generateStringSequence() -> [String] {
        var sequences: [String] = []
        for i in 1...self.count{
            sequences.append(String(self.prefix(i)))
        }
        //print(sequences)
        return sequences
    }
}
