//
//  Berhenti_Di_App.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/05/23.
//

import SwiftUI
import CoreData

@main
struct Berhenti_Di_App: App {
    let viewContext = PersistenceController.SHARED.Container_.viewContext
    let reminderViewModel = ReminderViewModel(viewContext: PersistenceController.SHARED.Container_.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(reminderViewModel)
        }
    }
}
