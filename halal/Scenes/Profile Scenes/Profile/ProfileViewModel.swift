//
//  ProfileViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 15.04.2023.
//

import SwiftUI
import Combine
import FirebaseAuth
    
final class ProfileViewModel: ViewModel {
    // MARK: - Properties
    @Published var settings: [Setting] = [
        Setting(name: "Изменить пароль", img: "lock.fill"),
        Setting(name: "Изменить язык", img: "globe"),
        Setting(name: "Рейтинг & Отзыв", img: "star"),
        Setting(name: "Мои запросы", img: "doc.on.doc"),
        Setting(name: "О нас", img: "exclamationmark.circle")
    ]
    
    @Published var settingsForAnonymous = [
        Setting(name: "Изменить язык", img: "globe"),
        Setting(name: "Рейтинг & Отзыв", img: "star"),
        Setting(name: "О нас", img: "exclamationmark.circle")
    ]
    
    func logout() async throws {
        let promise = logoutPromise()
        try await AsyncPromise.fulfill(promise, storedIn: &subscriptions)
//        do {
//            try Auth.auth().signOut()
//        } catch { print("already logged out") }
    }
    
    private func logoutPromise() -> Future<Void, Error> {
        Future { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch let error {
                promise(.failure(error))
            }
        }
    }
}
