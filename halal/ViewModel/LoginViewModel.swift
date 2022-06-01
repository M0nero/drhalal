//
//  LoginViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import Foundation
import Combine
import SwiftUI

protocol LoginViewModel {
    func login() async throws
    func signInWithGoogle() async throws
    var service: LoginService { get }
    var credentials: LoginCredentials { get }
    init(service: LoginService)
}


final class LoginViewModelImpl: ObservableObject, LoginViewModel {
    
    let service: LoginService
    @Published var credentials: LoginCredentials = LoginCredentials(email: "",
                                                                    password: "")
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: LoginService) {
        self.service = service
    }
    
    func login() async throws {
        let promise = service.login(with: credentials)
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
    func signInWithGoogle() async throws {
        let promise = service.signInWithGoogle()
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
}


