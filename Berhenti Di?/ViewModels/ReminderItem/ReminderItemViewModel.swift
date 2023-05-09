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
    var Reminder_: Reminder {
        return reminder_
    }
    
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
    
    private lazy var lazyReminderItemLastIndex_: Int16 = {
        guard let reminder = self.reminderItems_.max(by: { $0.index > $1.index })
        else { return 0 }
        
        return reminder.index
    }()
    
    @Published private var reminderItems_: [ReminderItem] = []
    var ReminderItems_: [ReminderItem] {
        return self.reminderItems_
    }
    
    @Published private var reminderItemLastIndex_: Int16 = 0
    var ReminderItemLastIndex_: Int16 {
        return self.reminderItemLastIndex_
    }
    
    init(viewContext: NSManagedObjectContext, reminder: Reminder) {
        self.viewContext_ = viewContext
        self.reminder_ = reminder
        
        super.init()
        
        self.reminderItems_ = self.fetchedResultsController.fetchedObjects ?? []
        self.reminderItemLastIndex_ = self.lazyReminderItemLastIndex_
        
        print("\(String(describing: ReminderItemViewModel.self)) rendered")
    }
}
