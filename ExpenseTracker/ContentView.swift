//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = ["Coffee - $5", "Groceries - 25", "Books - $10"]
    @State private var newExpense = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Add expense", text: $newExpense)
                Button(action: {
                    expenses.append(newExpense)
                    newExpense = ""
                }) {
                    Text("Add")
                }
            }
            .padding()
        }
        List(expenses, id: \.self) { item in
            Text(item)
        }
    }
}

#Preview {
    ContentView()
}
