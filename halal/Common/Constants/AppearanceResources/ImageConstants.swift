//
//  ImageConstants.swift
//  halal
//
//  Created by Damir Akbarov on 16.04.2023.
//

import UIKit

struct ImageConstants {
    
    private static func wrapper(_ value: UIImage?) -> UIImage {
        guard let value = value else {
            fatalError("ImageConstants handle nil value")
        }
        return value
    }
}
