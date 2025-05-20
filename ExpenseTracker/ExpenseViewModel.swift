//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import Foundation
import SwiftUI

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = [] {
        didSet {
            saveExpenses()
        }
    }

    let saveKey = "SavedExpenses"

    init() {
        loadExpenses()
    }

    func addExpense(name: String, amount: Double) {
        let new = Expense(name: name, amount: amount)
        expenses.append(new)
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    private func saveExpenses() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = decoded
        }
    }

    func totalAmount() -> Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
}
