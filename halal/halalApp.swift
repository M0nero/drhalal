//
//  halalApp.swift
//  halal
//
//  Created by Damir Akbarov on 11.04.2022.
//

import SwiftUI

@main
struct halalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
