//
//  ContentView.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/05/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext_
    
    @EnvironmentObject private var reminderViewModel_: ReminderViewModel
    
    init() {
        print("\(String(describing: ContentView.self)) rendered")
    }
    
    // TODO: SOLID Design Principles
    var body: some View {
        NavigationView {
            List {
                ForEach(self.reminderViewModel_.Reminders_, id: \.self) { reminder in
//                ForEach(0..<self.reminderViewModel_.Reminders_, id: \.self) { index in
                    NavigationLink {
                        if let reminderItems = reminder.GetReminderItems() {
//                        if let reminderItems = self.reminderViewModel_.Reminders_[index].GetReminderItems() {
                            ForEach(reminderItems, id: \.self) {
                                reminderItem in
                                if let name = reminderItem.name {
                                    Text("\(name)")
                                }
                            }
                        }
                    } label: {
                        if let name = reminder.name {
//                        if let name = self.reminderViewModel_.Reminders_[index].name {
                            Text("\(name)")
                        }
                    }
                }
                .onDelete(perform: {
                    offsets in
                    withAnimation {
                        let _ = self.reminderViewModel_.DeleteReminder(offsets: offsets)
                        PersistenceController.Save(viewContext: self.viewContext_)
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            let _ = self.reminderViewModel_.AddReminder(name: "reminder", index: self.reminderViewModel_.ReminderLastIndex_)
                            PersistenceController.Save(viewContext: self.viewContext_)
                        }
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.PREVIEW.Container_.viewContext
        let reminderViewModel = ReminderViewModel(viewContext: viewContext)
        ContentView()
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(reminderViewModel)
    }
}
