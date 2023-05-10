//
//  ReminderItemViewModel.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation
import CoreData

class ReminderItemViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate, ReminderItemViewModelProtocol {
    private let viewContext_: NSManagedObjectContext
    
    @Published private var reminder_: Reminder
    var Reminder_: Reminder { return self.reminder_ }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<ReminderItem> = {
        let fetchRequest = ReminderItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "reminder == %@", self.reminder_)
        
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
    
    @Published private var reminderItems_: [ReminderItem] = []
    var ReminderItems_: [ReminderItem] { return self.reminderItems_ }
    
    var ReminderItemLastIndex_: Int16 {
        guard let reminder = self.ReminderItems_.max(by: { $0.index < $1.index })
        else { return -1 }
        
        return reminder.index
    }
    
    init(viewContext: NSManagedObjectContext, reminder: Reminder) {
        self.viewContext_ = viewContext
        self.reminder_ = reminder
        
        super.init()
        
        self.reminderItems_ = self.fetchedResultsController.fetchedObjects ?? []
        
        #if DEBUG
            print("\(String(describing: ReminderItemViewModel.self)) initialized")
        #endif
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        #if DEBUG
            print("\(String(describing: ReminderItemViewModel.self)) \(#function) called")
        #endif
        self.reminderItems_ = controller.fetchedObjects as? [ReminderItem] ?? []
    }
}
