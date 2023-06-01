//
//  ViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 16.04.2023.
//

import Combine

class ViewModel: ObservableObject {
    var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
}
