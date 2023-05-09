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
        
        let reminder1 = Reminder(context: viewContext)
        reminder1.index = 1
        reminder1.name = "reminder1"
        
        let reminder0 = Reminder(context: viewContext)
        reminder0.index = 0
        reminder0.name = "reminder0"
        
        let reminderItem0 = ReminderItem(context: viewContext)
        reminderItem0.index = 0
        reminderItem0.name = "reminderItem0"
        reminderItem0.reminder = reminder0
        
        let reminderItem1 = ReminderItem(context: viewContext)
        reminderItem1.index = 1
        reminderItem1.name = "reminderItem1"
        reminderItem1.reminder = reminder0
        
        let reminderItem2 = ReminderItem(context: viewContext)
        reminderItem2.index = 2
        reminderItem2.name = "reminderItem2"
        reminderItem2.reminder = reminder0
        
        let reminderItem3 = ReminderItem(context: viewContext)
        reminderItem3.index = 3
        reminderItem3.name = "reminderitem3"
        reminderItem3.reminder = reminder0
        
        PersistenceController.Save(viewContext: viewContext, fatal: true)
        return result
    }()
}
