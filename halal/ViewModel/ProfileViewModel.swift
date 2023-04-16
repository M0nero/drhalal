//
//  ContentViewModel.swift
//  halal
//
//  Created by Damir Akbarov on 15.04.2022.
//

import SwiftUI
import Combine

extension ProfileView {
    
    class ViewModel: ObservableObject {
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
        
        var cancellables: Set<AnyCancellable> = []
        
//        func logout() async throws {
//            let promise = AuthService.logout()
//            try await AsyncPromise.fulfill(promise, storedIn: &cancellables)
            
//        }
    }
}
