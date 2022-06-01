//
//  Subcategory.swift
//  halal
//
//  Created by Damir Akbarov on 03.05.2022.
//

import Foundation

struct Subcategory: Identifiable{
    var id: String { name }
    let name: String
    let img: String
    
    init(name: String, img: String) {
        self.name = name
        self.img = img
    }
}
