//
//  RegistrationViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import Foundation
import Combine
import Firebase

protocol RegistrationViewModel {
    func create() async throws
    func signInAnonymously() async throws
    var service: RegistrationService { get }
    var newUser: RegistrationCredentials { get }
    init(service: RegistrationService)
}

final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    
    
    let service: RegistrationService
    @Published var newUser = RegistrationCredentials(email: "",
                                                     password: "",
                                                     userName: "",
                                                     profileImgUrl: "")

    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegistrationService) {
        self.service = service
        
    }
    
    func create() async throws {
        let promise = service.register(with: newUser)
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
    func signInAnonymously() async throws {
        let promise = service.signInAnonymously()
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
    }
    
}
