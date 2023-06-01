//
//  Binding+Ext.swift
//  halal
//
//  Created by Damir Akbarov on 15.05.2023.
//

import SwiftUI

extension Binding {
    func map<T>(get: @escaping (Value) -> T?, set: @escaping (T?) -> Value) -> Binding<T?> {
        Binding<T?>(
            get: {
                get(wrappedValue)
            },
            set: {
                wrappedValue = set($0)
            }
        )
    }
}
