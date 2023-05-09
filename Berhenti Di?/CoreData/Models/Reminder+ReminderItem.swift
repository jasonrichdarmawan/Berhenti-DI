//
//  Reminder+ReminderItem.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation

extension Reminder: ReminderProtocol {
    func GetReminderItems() -> [ReminderItem]? {
        return self.reminderItems?.sortedArray(using: [NSSortDescriptor(key: "index", ascending: true)]) as? [ReminderItem]
    }
}
