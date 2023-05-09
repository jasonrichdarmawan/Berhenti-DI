//
//  CRUDProtocol.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation
import CoreData

protocol ReminderViewModelProtocol {
    /**
     Expectation: View call PersistenceController.Save(viewContext: viewContext) to save.
     */
    func AddReminder(name: String, index: Int16) -> Reminder
    
    /**
     Expectation: View call PersistenceController.Save(viewContext: viewContext) to save.
     */
    func DeleteReminder(offsets: IndexSet) -> Bool
}
