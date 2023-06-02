//
//  LoginViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2023.
//

import Foundation
import Combine
import SwiftUI

protocol LoginViewModel: ViewModel {
    func login() async throws
    func signInWithGoogle() async throws
    var service: LoginService { get }
    var credentials: LoginCredentials { get }
}

final class LoginViewModelImpl: ViewModel, LoginViewModel {
    
    @Inject var service: LoginService
    @Published var credentials: LoginCredentials = LoginCredentials(email: "", password: "")
    
    func login() async throws {
        let promise = service.login(with: credentials)
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
    func signInWithGoogle() async throws {
        let promise = service.signInWithGoogle()
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
}
