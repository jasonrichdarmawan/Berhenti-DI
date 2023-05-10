//
//  LazyView.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import SwiftUI

/// Expected behavior:
/// NavigationLink.destination.body called -> self.content_() called
///
/// How to use:
///
///     NavigationLink {
///         LazyView {
///             RenderItemView(reminderItemViewModel: ReminderItemViewModel(viewContext: self.viewContext_, reminder: reminder))
///         }
///     } label: {
///         Text("\(reminder.index) \(reminder.name ?? "Nama rute?")")
///     }
struct LazyView<Content: View>: View {
    private let content_: () -> Content
    
    init(content: @escaping () -> Content) {
        self.content_ = content
    }
    
    var body: some View {
        self.content_()
    }
}
