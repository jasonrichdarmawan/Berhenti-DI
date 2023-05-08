//
//  Persistence.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/05/23.
//

import CoreData

struct PersistenceController {
    static let SHARED = PersistenceController()

    let Container_: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        Container_ = NSPersistentCloudKitContainer(name: "Berhenti_Di_")
        if inMemory {
            Container_.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        Container_.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TODO: handle the error appropriately.
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        Container_.viewContext.automaticallyMergesChangesFromParent = true
    }
}
