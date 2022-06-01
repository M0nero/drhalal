//
//  Category.swift
//  halal
//
//  Created by Damir Akbarov on 03.05.2022.
//

import Foundation
import UIKit

struct Category: Identifiable{
    var id: String { name }
    let color: UIColor
    let name: String
    let img: String
    let subcategories: [Subcategory]
    
    init(name: String, color: UIColor, img: String, subcategories: [Subcategory]) {
        self.name = name
        self.color = color
        self.img = img
        self.subcategories = subcategories
    }
}
