//
//  RenderItemView.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import SwiftUI
import CoreData

struct RenderItemView: View {
    @ObservedObject private var reminderItemViewModel_: ReminderItemViewModel
    
    init(reminderItemViewModel: ReminderItemViewModel) {
        self.reminderItemViewModel_ = reminderItemViewModel
        
        #if DEBUG
            print("\(String(describing: RenderItemView.self)) initialized")
        #endif
    }
    
    var body: some View {
        VStack {
            ForEach(self.reminderItemViewModel_.ReminderItems_, id: \.self) {
                reminderItem in
                if let name = reminderItem.name {
                    Text("\(name)")
                }
            }
        }
        .onAppear {
            #if DEBUG
                print("\(String(describing: RenderItemView.self)) appeared")
            #endif
        }
        .onDisappear {
            #if DEBUG
                print("\(String(describing: RenderItemView.self)) disappeared")
            #endif
        }
    }
    
}
