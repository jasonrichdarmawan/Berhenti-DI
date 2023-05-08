//
//  Berhenti_Di_App.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/05/23.
//

import SwiftUI

@main
struct Berhenti_Di_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
