//
//  ForgotPasswordViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import Foundation
import Combine

protocol ForgotPasswordViewModel {
    var service: ForgotPasswordService { get }
    var email: String { get }
    init(service: ForgotPasswordService)
    func sendPasswordResetRequest() async throws
}

final class ForgotPasswordViewModelImpl: ObservableObject, ForgotPasswordViewModel {
    
    let service: ForgotPasswordService
    @Published var email: String = ""

    private var subscriptions = Set<AnyCancellable>()
    
    init(service: ForgotPasswordService) {
        self.service = service
    }
    
    func sendPasswordResetRequest() async throws{
        let promise = service.sendPasswordResetRequest(to: email)
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
}
