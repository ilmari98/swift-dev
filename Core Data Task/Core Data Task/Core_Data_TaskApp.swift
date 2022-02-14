//
//  Core_Data_TaskApp.swift
//  Core Data Task
//
//  Created by Ilmari Lehmusjärvi on 7.2.2022.
//

import SwiftUI

@main
struct Core_Data_TaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
