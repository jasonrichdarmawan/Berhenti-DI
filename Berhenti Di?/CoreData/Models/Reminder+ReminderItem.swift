//
//  Reminder+ReminderItem.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation

extension Reminder: ReminderProtocol {
    func CreateReminderItem(name: String) -> ReminderItem? {
        guard let viewContext = self.managedObjectContext else { return nil }
        
        let reminderItem = ReminderItem(context: viewContext)
        reminderItem.name = name
        
        // Reminder have firstItem
        // firstItem have nextItem
        // loop until nextItem is nil
        if var currentItem = self.firstItem {
            while let nextItem = currentItem.nextItem {
                currentItem = nextItem
            }
            
            currentItem.nextItem = reminderItem
        } else {
            self.firstItem = reminderItem
        }
        
        PersistenceController.Save(viewContext: viewContext)
        
        return reminderItem
    }
}
