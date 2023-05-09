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
        
        let reminder1 = Reminder.CreateReminder(viewContext: viewContext, name: "reminder1", index: 1)
        let reminder0 = Reminder.CreateReminder(viewContext: viewContext, name: "reminder0", index: 0)
        
        let _ = reminder0.CreateReminderItem(name: "reminderItem0", index: 0)
        let _ = reminder0.CreateReminderItem(name: "reminderItem1", index: 1)
        let _ = reminder0.CreateReminderItem(name: "reminderItem2", index: 2)
        let _ = reminder0.CreateReminderItem(name: "reminderItem3", index: 3)
        
        let _ = reminder1.CreateReminderItem(name: "reminderItem0", index: 0)
        
        PersistenceController.Save(viewContext: viewContext, fatal: true)
        return result
    }()
}
