//
//  RegistrationViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2023.
//

import Foundation
import Combine

protocol RegistrationViewModel {
    func create() async throws
    func signInAnonymously() async throws
    var service: RegistrationService { get }
    var newUser: RegistrationCredentials { get }
}

final class RegistrationViewModelImpl: ViewModel, RegistrationViewModel {
    
    @Inject var service: RegistrationService
    @Published var newUser = RegistrationCredentials(email: "",
                                                     password: "",
                                                     userName: "",
                                                     profileImgUrl: "")
    
    func create() async throws {
        let promise = service.register(with: newUser)
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
    func signInAnonymously() async throws {
        let promise = service.signInAnonymously()
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
}
