//
//  HalalApp.swift
//  halal
//
//  Created by Damir Akbarov on 11.04.2023.
//

import SwiftUI

@main
struct HalalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var sessionService = SessionServiceImpl()
    @StateObject var coordinator = TabBarCoordinator()
    
    var body: some Scene {
        WindowGroup {
            switch sessionService.state {
            case .undefined:
                ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
            case .loggedOut:
                LoginView()
                    .environmentObject(sessionService)
            case .loggedIn:
                TabBarCoordinatorView(coordinator: coordinator)
                    .environmentObject(sessionService)
            }
        }
    }
}
