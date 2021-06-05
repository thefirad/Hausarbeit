//
//  CoachCarterV2App.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI

@main
struct CoachCarterV2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
