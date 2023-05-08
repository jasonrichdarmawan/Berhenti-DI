//
//  PersistenceController+Helper.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import CoreData

extension PersistenceController {
    static public func Save(viewContext: NSManagedObjectContext, fatal: Bool = false) {
        do {
            try viewContext.save()
        } catch {
            // TODO: handle the error appropriately.
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            if fatal {
                fatalError()
            }
        }
    }
}
