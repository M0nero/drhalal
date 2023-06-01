//
//  SearchViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 25.05.2023.
//

import SwiftUI
import Foundation

final class SearchViewModel: ViewModel {
    // MARK: - Properties
    private unowned let coordinator: SearchCoordinator
    @AppStorage("lastRequests") var lastRequests: [String] = []
    
    // MARK: - Init
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Public methods
    func processLastSearch(keyword: String) {
        let filteredKeyword = keyword.trimmingCharacters(in: .whitespaces)
        guard !filteredKeyword.isEmpty else { return }
        if let index = lastRequests.firstIndex(of: filteredKeyword) {
            lastRequests.remove(at: index)
        } else if lastRequests.count > 7 {
            lastRequests.remove(at: 0)
        }
        lastRequests.append(filteredKeyword)
    }
}
