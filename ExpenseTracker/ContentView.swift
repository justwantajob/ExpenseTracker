//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses: [Expense] = [
        Expense(name: "Coffee", amount: 5),
        Expense(name: "Groceries", amount: 25)
    ]

    @State private var newName = ""
    @State private var newAmount = ""
    
    func totalAmount() -> Double {
        expenses.reduce(0) {$0 + $1.amount}
    }
    
    func deleteItems(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    var body: some View {
        VStack {
            HStack {
                TextField("Expense Name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Amount", text: $newAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    if let amount = Double(newAmount) {
                        let expense = Expense(name: newName, amount: amount)
                        expenses.append(expense)
                        newName = ""
                        newAmount = ""
                    }
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()

            List {
                ForEach(expenses) { expense in
                    HStack {
                        Text(expense.name)
                        Spacer()
                        Text("$\(expense.amount, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            Text("Total: $\(totalAmount(), specifier: "%.2f")")
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
