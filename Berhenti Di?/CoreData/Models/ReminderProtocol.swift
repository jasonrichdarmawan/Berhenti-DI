//
//  ReminderProtocol.swift
//  Berhenti Di?
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/05/23.
//

import Foundation

protocol ReminderProtocol {
    func CreateReminderItem(name: String) -> ReminderItem?
}
