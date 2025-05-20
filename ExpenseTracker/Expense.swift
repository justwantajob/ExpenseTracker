//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
}
