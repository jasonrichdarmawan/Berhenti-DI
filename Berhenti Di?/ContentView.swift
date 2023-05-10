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
        #if DEBUG
            print("\(String(describing: ContentView.self)) initialized")
        #endif
    }
    
    // TODO: SOLID Design Principles
    var body: some View {
        NavigationView {
            List {
                ForEach(self.reminderViewModel_.Reminders_, id: \.self) { reminder in
                    NavigationLink {
                        LazyView {
                            RenderItemView(reminderItemViewModel: ReminderItemViewModel(viewContext: self.viewContext_, reminder: reminder))
                        }
                    } label: {
                        // TODO: placeholder `Nama rute?`
                        Text("\(reminder.index) \(reminder.name ?? "Nama rute?")")
                    }
                }
                .onDelete(perform: self.deleteReminder)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: self.createReminder) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .onAppear {
            #if DEBUG
                print("\(String(describing: ContentView.self)) appeared")
            #endif
        }
        .onDisappear {
            #if DEBUG
                print("\(String(describing: ContentView.self)) disappeared")
            #endif
        }
    }
    
    private func createReminder() {
        withAnimation {
            let _ = self.reminderViewModel_.CreateReminder(name: "reminder", index: self.reminderViewModel_.ReminderLastIndex_ + 1)
        }
    }
    
    private func deleteReminder(offsets: IndexSet) {
        withAnimation {
            let _ = self.reminderViewModel_.DeleteReminder(offsets: offsets)
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
