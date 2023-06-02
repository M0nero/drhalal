//
//  ProductsListViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 27.04.2023.
//

import SwiftUI
import Foundation

final class ProductsListViewModel: ViewModel {
    // MARK: - Services
    @Inject private var service: ProductServiceProtocol
    
    // MARK: - Properties
    @Published var queryResultProducts: [Product] = []
    @Published var isEmptyProducts: Bool = false
    @Published var keyword = ""
    @Published var subcategoryId = 0
    @Published var flow: ProductListFlow
    @Published var state: State = .good {
        didSet {
            print("state changed to: \(state)")
        }
    }
    
    @AppStorage("lastRequests") var lastRequests: [String] = []
    
    private unowned let coordinator: ListCoordinatorProtocol
    
    enum State: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    
    // MARK: - Private properties
    private var page = 0
    private let limit = 10
    
    // MARK: - Init
    init(_ flow: ProductListFlow,
         subcategoryId: Int? = nil,
         coordinator: ListCoordinatorProtocol) {
        self.flow = flow
        self.coordinator = coordinator
        super.init()
        switch flow {
        case .search:
            bindKeyword()
        case .subcategory:
            self.subcategoryId = subcategoryId ?? 0
            resetPage()
        }
    }
    
    // MARK: - Public methods
    func getNextData() {
        guard state == .good else { return }
        if flow == .search {
            guard !keyword.isEmpty else { return }
        }
        state = .isLoading
        page += 1
        let request = flow == .search ?
        service.getProducts(page: page, limit: limit, keyword: keyword) :
        service.getProductsInSubcategory(id: subcategoryId, page: page, limit: limit)
        
        request
            .sink(receiveCompletion: { [weak self] completion in
                guard let error = try? completion.error().localizedDescription else { return }
                DispatchQueue.main.async {
                    self?.state = .error("Could not load: \(error)")
                }
            },
                  receiveValue: { [weak self] products in
                guard let self = self else { return }
                self.queryResultProducts += products
                isEmptyProducts = self.queryResultProducts.isEmpty
                self.state = (products.count == 10) ? .good : .loadedAll
            })
            .store(in: &subscriptions)
    }
    
    func processLastSearch() {
        let filteredKeyword = keyword.trimmingCharacters(in: .whitespaces)
        guard !filteredKeyword.isEmpty else { return }
        if let index = lastRequests.firstIndex(of: filteredKeyword) {
            lastRequests.remove(at: index)
        } else if lastRequests.count > 7 {
            lastRequests.remove(at: 0)
        }
        lastRequests.append(filteredKeyword)
    }
    
    func open(_ product: Product) {
        coordinator.openProduct(product)
    }
    
    // MARK: - Private methods
    private func resetPage() {
        state = .good
        page = 0
        queryResultProducts = []
        getNextData()
    }
    
    private func bindKeyword() {
        $keyword
            .dropFirst()
            .debounce(for: 0.9, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.resetPage()
            }
            .store(in: &subscriptions)
    }
}
