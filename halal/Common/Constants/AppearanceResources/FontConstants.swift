//
//  FontConstants.swift
//  halal
//
//  Created by Damir Akbarov on 16.04.2023.
//

import UIKit

struct FontConstants {
    let normalBold: UIFont = wrapper(UIFont(name: CustomFontType.bold.rawValue, size: 15))
    let bigBold: UIFont = wrapper(UIFont(name: CustomFontType.bold.rawValue, size: 18))
    let largeBold: UIFont = wrapper(UIFont(name: CustomFontType.bold.rawValue, size: 24))
    
    let normalSemiBold: UIFont = wrapper(UIFont(name: CustomFontType.semibold.rawValue, size: 16))
    let bigSemiBold: UIFont = wrapper(UIFont(name: CustomFontType.semibold.rawValue, size: 18))
    
    let verySmallRegular: UIFont = wrapper(UIFont(name: CustomFontType.regular.rawValue, size: 12))
    let smallRegular: UIFont = wrapper(UIFont(name: CustomFontType.regular.rawValue, size: 14))
    let normalRegular: UIFont = wrapper(UIFont(name: CustomFontType.regular.rawValue, size: 16))
    
    private static func wrapper(_ value: UIFont?) -> UIFont {
        guard let value = value else {
            for family: String in UIFont.familyNames {
                print(family)
                for names: String in UIFont.fontNames(forFamilyName: family) {
                    print("== \(names)")
                }
            }
            fatalError("FontConstants handle nil value")
        }
        return value
    }
}

private enum CustomFontType: String {
    case bold = "AvertaCYW01-Bold"
    case semibold = "AvertaCYW10-Semibold"
    case regular = "AvertaCYW10-Regular"
}
