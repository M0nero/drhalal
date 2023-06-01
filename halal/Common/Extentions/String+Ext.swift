//
//  String+Ext.swift
//  halal
//
//  Created by Damir Akbarov on 25.04.2023.
//

import Foundation

extension String {
    func generateStringSequence() -> [String] {
        var sequences: [String] = []
        for index in 1...self.count {
            sequences.append(String(self.prefix(index)))
        }
        return sequences
    }
}
