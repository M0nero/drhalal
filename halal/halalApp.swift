//
//  halalApp.swift
//  halal
//
//  Created by Damir Akbarov on 11.04.2022.
//

import SwiftUI
import FirebaseService

@main
struct halalApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var authState = AuthState()
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            switch authState.value {
            case .undefined:
                ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
            case .notAuthenticated:
                LoginView()
                    .environmentObject(sessionService)
            case .authenticated:
                TabBar()
                    .environmentObject(sessionService)
            }
        }
    }
}
