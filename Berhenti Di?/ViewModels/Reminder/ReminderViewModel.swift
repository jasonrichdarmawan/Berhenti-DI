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
    
    private lazy var lazyReminderLastIndex_: Int16 = {
        guard let reminder = self.Reminders_.max(by: { $0.index > $1.index })
        else { return 0 }
        
        return reminder.index
    }()
    
    @Published private var reminders_: [Reminder] = []
    var Reminders_: [Reminder] {
        return self.reminders_
    }
    
    @Published private var reminderLastIndex_: Int16 = 0
    var ReminderLastIndex_: Int16 {
        return self.reminderLastIndex_
    }
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext_ = viewContext
        
        super.init()
        
        self.reminders_ = self.fetchedResultsController.fetchedObjects ?? []
        self.reminderLastIndex_ = self.lazyReminderLastIndex_
        
        print("\(String(describing: ReminderViewModel.self)) rendered")
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.reminders_ = controller.fetchedObjects as? [Reminder] ?? []
    }
    
    func AddReminder(name: String, index: Int16) -> Reminder {
        let reminder = Reminder.CreateReminder(viewContext: self.viewContext_, name: name, index: index)
        
        return reminder
    }
    
    func DeleteReminder(offsets: IndexSet) -> Bool {
        offsets.map { self.Reminders_[$0] }.forEach(self.viewContext_.delete)
        
        return true
    }
}
