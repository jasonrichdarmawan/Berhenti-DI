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
        
        let reminderViewModel = ReminderViewModel(viewContext: viewContext)
        let reminder1 = reminderViewModel.CreateReminder(name: "reminder1", index: 1)
        let reminder0 = reminderViewModel.CreateReminder(name: "reminder0", index: 0)
        
        PersistenceController.Save(viewContext: viewContext, fatal: true)
        
        let _ = reminder0.CreateReminderItem(name: "reminderItem0", index: 0, checked: false)
        let _ = reminder0.CreateReminderItem(name: "reminderItem1", index: 1, checked: false)
        let _ = reminder0.CreateReminderItem(name: "reminderItem2", index: 2, checked: false)
        let _ = reminder0.CreateReminderItem(name: "reminderItem3", index: 3, checked: false)
        
        let _ = reminder1.CreateReminderItem(name: "reminderItem0", index: 0, checked: false)
        
        PersistenceController.Save(viewContext: viewContext, fatal: true)
        return result
    }()
}
