//
//  bookwormApp.swift
//  Shared
//
//  Created by Daniel Lucena Pires on 08/05/23.
//

import SwiftUI

@main
struct bookwormApp: App {
    let persistenceContainer = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)

        }
    }
}
