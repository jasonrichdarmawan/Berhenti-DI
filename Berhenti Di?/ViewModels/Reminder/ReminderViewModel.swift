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
    
    private lazy var lazyFetchedResultsController: NSFetchedResultsController<Reminder> = {
        let fetchRequest = Reminder.fetchRequest()
        
        // lazy fetching
        fetchRequest.relationshipKeyPathsForPrefetching = []
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: false)]
        
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
    @Published var reminders_: [Reminder] = []
    var Reminders_: [Reminder] { return self.reminders_ }

    var ReminderLastIndex_: Int16 {
        guard let reminder = self.Reminders_.max(by: { $0.index < $1.index })
        else { return -1 }
        
        return reminder.index
    }
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext_ = viewContext
        
        super.init()
        
        self.reminders_ = self.lazyFetchedResultsController.fetchedObjects ?? []
        
        #if DEBUG
            print("\(String(describing: ReminderViewModel.self)) initialized")
        #endif
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        #if DEBUG
            print("\(String(describing: ReminderViewModel.self)) \(#function) called")
        #endif
        self.reminders_ = controller.fetchedObjects as? [Reminder] ?? []
    }
    
    func CreateReminder(name: String, index: Int16) -> Reminder {
        let reminder = Reminder.CreateReminder(viewContext: self.viewContext_, name: name, index: index)
        
        PersistenceController.Save(viewContext: self.viewContext_)
        
        return reminder
    }
    
    func DeleteReminder(offsets: IndexSet) -> Bool {
        offsets.map { self.Reminders_[$0] }.forEach(self.viewContext_.delete)
        
        PersistenceController.Save(viewContext: self.viewContext_)
        
        return true
    }
}
