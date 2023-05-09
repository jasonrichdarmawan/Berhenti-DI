//
//  RenderItemView.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import SwiftUI
import CoreData

/**
 Do not initialize view model in init.
 Otherwise, you will initialize the view model even though you have not view it yet.
 
 TODO: RenderItemView initialize reminderItemViewModel everytime re-render.
 */
struct RenderItemView: View {
    private let viewContext_: NSManagedObjectContext
    private let reminder_: Reminder
    
    init(viewContext: NSManagedObjectContext, reminder: Reminder) {
        self.viewContext_ = viewContext
        self.reminder_ = reminder
    }
    
    var body: some View {
        let reminderItemViewModel = ReminderItemViewModel(viewContext: self.viewContext_, reminder: self.reminder_)
        ForEach(reminderItemViewModel.ReminderItems_, id: \.self) {
            reminderItem in
            if let name = reminderItem.name {
                Text("\(name)")
            }
        }
    }
    
}
