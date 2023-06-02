//
//  ScannerViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 02.06.2023.
//

import SwiftUI
import Foundation

final class ScannerViewModel: ViewModel {
    // MARK: - Services
    @Inject private var service: ProductServiceProtocol
    
    // MARK: - Properties
    @Published var resultProduct: Product?
    @Published var isLoading: Bool = false
    @Published var isScanning: Bool = false
    @Published var scanDelegate = ScannerDelegate()
    @Published  var cameraPermission: Permission = .idle
    private unowned let coordinator: ListCoordinatorProtocol
    
    // MARK: - Error properties
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    // MARK: - Init
    init(coordinator: ScannerCoordinator) {
        self.coordinator = coordinator
        super.init()
        bindFoundedCode()
    }
    
    // MARK: - Public methods
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
    // MARK: - Public methods
    private func bindFoundedCode() {
        scanDelegate.$scannedCode
            .removeDuplicates()
            .sink { [weak self] value in
                guard let value = value else { return }
                self?.getData(by: value)
            }
            .store(in: &subscriptions)
    }
    
    private func getData(by cis: String) {
        service.getProduct(by: cis)
            .sink(receiveCompletion: { [weak self] completion in
                guard let error = try? completion.error() else { return }
                if error.asAFError?.responseCode == 404 {
                    self?.presentError("Не найдено")
                } else {
                    self?.presentError(error.localizedDescription)
                }
            },
                  receiveValue: { [weak self] product in
                guard let self = self else { return }
                self.resultProduct = product
                self.open(product)
            })
            .store(in: &subscriptions)
    }
    
    private func open(_ product: Product) {
        coordinator.openProduct(product)
    }
}
