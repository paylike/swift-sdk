//
//  ExampleApp.swift
//
//  Created by Laszlo Kocsis on 2023. 04. 20..
//

import SwiftUI

@main
struct ExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
