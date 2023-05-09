//
//  ReminderProtocol.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import CoreData

protocol ReminderProtocol {
    /**
     Expectation:
     This method is executed in a View that have the last index of Reminder entities.
    */
    static func CreateReminder(viewContext: NSManagedObjectContext, name: String, index: Int16) -> Reminder
    
    /**
     Expectation:
     This method is executed in a View that have a Reminder entity.
     */
    func CreateReminderItem(name: String, index: Int16) -> ReminderItem?
    
    /**
     Behavior:
     The returned data will not automatically update when there is a change.
     
     DEPRECEATED:
     Use ReminderItemViewModel (not yet exist as of this commit)
     */
    func GetReminderItems() -> [ReminderItem]?
}
