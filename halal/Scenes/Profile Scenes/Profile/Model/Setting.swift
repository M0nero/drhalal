//
//  Setting.swift
//  halal
//
//  Created by Damir Akbarov on 13.05.2023.
//

import Foundation
import SwiftUI

struct Setting: Identifiable {
    var id: String { name }
    let name: String
    let img: String
    let link: String?
    
    init(name: String, img: String, link: String = "") {
        self.name = name
        self.img = img
        self.link = link
    }
}
