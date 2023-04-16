//
//  halalApp.swift
//  halal
//
//  Created by Damir Akbarov on 11.04.2022.
//

import SwiftUI

@main
struct halalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var sessionService = SessionServiceImpl()
    
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
                TabBar()
                    .environmentObject(sessionService)
            }
        }
    }
}
