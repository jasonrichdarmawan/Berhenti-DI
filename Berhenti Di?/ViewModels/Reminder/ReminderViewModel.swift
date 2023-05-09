//
//  CoreDataListViewModel.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/05/23.
//

import SwiftUI
import CoreData

class ReminderViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate, ReminderViewModelProtocol {
    private let viewContext_: NSManagedObjectContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Reminder> = {
        let fetchRequest = Reminder.fetchRequest()
        
        // lazy fetching
        fetchRequest.relationshipKeyPathsForPrefetching = []
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: self.viewContext_,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            // TODO: handle the error appropriately.
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return controller
    }()
    
    @Published var Reminders_: [Reminder] = []
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext_ = viewContext
        
        super.init()
        
        self.Reminders_ = fetchedResultsController.fetchedObjects ?? []
        
        print("\(String(describing: ReminderViewModel.self)) rendered")
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.Reminders_ = controller.fetchedObjects as? [Reminder] ?? []
    }
    
    func AddReminder(name: String) -> Reminder {
        let reminder = Reminder(context: self.viewContext_)
        reminder.name = "reminder"
        
        PersistenceController.Save(viewContext: self.viewContext_)
        
        return reminder
    }
    
    func DeleteReminder(offsets: IndexSet) -> Bool {
        offsets.map { self.Reminders_[$0] }.forEach(self.viewContext_.delete)
        
        PersistenceController.Save(viewContext: self.viewContext_)
        
        return true
    }
}
