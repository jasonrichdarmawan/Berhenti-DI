//
//  ReminderItemViewModelProtocol.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation

protocol ReminderItemViewModelProtocol {
    var Reminder_: Reminder { get }
    var ReminderItems_: [ReminderItem] { get }
    var ReminderItemLastIndex_: Int16 { get }
}
