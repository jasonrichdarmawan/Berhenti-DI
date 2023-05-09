//
//  Reminder+ReminderItem.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import CoreData

extension Reminder: ReminderProtocol {
    static func CreateReminder(viewContext: NSManagedObjectContext, name: String, index: Int16) -> Reminder {
        let reminder = Reminder(context: viewContext)
        reminder.index = index
        reminder.name = name
        
        return reminder
    }
    
    func CreateReminderItem(name: String, index: Int16, checked: Bool) -> ReminderItem? {
        var reminderItem: ReminderItem?
        
        if let viewContext = self.managedObjectContext {
            reminderItem = ReminderItem(context: viewContext)
            reminderItem?.index = index
            reminderItem?.name = name
            reminderItem?.checked = checked
            reminderItem?.reminder = self
        }
        
        return reminderItem
    }
    
    func GetReminderItems() -> [ReminderItem]? {
        return self.reminderItems?.sortedArray(using: [NSSortDescriptor(key: "index", ascending: true)]) as? [ReminderItem]
    }
}
