//
//  ColorConstants.swift
//  halal
//
//  Created by Damir Akbarov on 16.04.2023.
//

import UIKit

struct ColorConstants {
    private static func wrapper(_ value: UIColor?) -> UIColor {
        guard let value = value else {
            fatalError("ColorConstants handle nil value")
        }
        return value
    }
}
