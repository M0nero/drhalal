//
//  AppDelegateAdaptor.swift
//  halal
//
//  Created by Damir Akbarov on 15.04.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AppModule().registerDependencies(in: Resolver.shared.container)
        ServiceModule().registerDependencies(in: Resolver.shared.container)
        NetworkModule().registerDependencies(in: Resolver.shared.container)
        return true
    }
}
