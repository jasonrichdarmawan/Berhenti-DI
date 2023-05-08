//
//  CRUDProtocol.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation
import CoreData

protocol ReminderViewModelProtocol {
    func AddReminder(name: String) -> Reminder
    func DeleteReminder(offsets: IndexSet) -> Bool
}
