//
//  ProductViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 27.05.2023.
//

import SwiftUI
import Combine
import Foundation

final class ProductViewModel: ViewModel, Identifiable {
    // MARK: - Properties
    @Published var product: Product
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private unowned let coordinator: ListCoordinatorProtocol
    
    // MARK: - Init
    init(product: Product, coordinator: ListCoordinatorProtocol) {
        self.coordinator = coordinator
        self.product = product
    }
    
    func notify() {
        objectWillChange.send()
    }
}
