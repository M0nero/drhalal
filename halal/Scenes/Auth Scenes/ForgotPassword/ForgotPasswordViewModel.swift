//
//  ForgotPasswordViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2023.
//

import Foundation
import Combine

protocol ForgotPasswordViewModel: ViewModel {
    var service: ForgotPasswordService { get }
    var email: String { get }
    func sendPasswordResetRequest() async throws
}

final class ForgotPasswordViewModelImpl: ViewModel, ForgotPasswordViewModel {
    
    @Inject var service: ForgotPasswordService
    @Published var email: String = ""
    
    func sendPasswordResetRequest() async throws {
        let promise = service.sendPasswordResetRequest(to: email)
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
}
