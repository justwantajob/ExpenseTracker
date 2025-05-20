//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import Foundation

enum ExpenseCategory: String, CaseIterable, Codable, Identifiable {
    var id: String {self.rawValue}
    case food = "Yiyecek"
    case transportation = "Ulaşım"
    case entertainment = "Eğlence"
    case clothing = "Giyim"
    case bills = "Faturalar"
    case other = "Diğer"
}

struct Expense: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
    var category: ExpenseCategory
}
