//
//  PersistenceController+PREVIEW.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import CoreData

extension PersistenceController {
    static var PREVIEW: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.Container_.viewContext
        
        let reminder = Reminder(context: viewContext)
        reminder.name = "reminder"
        
        let _ = reminder.CreateReminderItem(name: "reminderItem1")
        let _ = reminder.CreateReminderItem(name: "reminderItem2")
        
        PersistenceController.Save(viewContext: viewContext, fatal: true)
        return result
    }()
}
