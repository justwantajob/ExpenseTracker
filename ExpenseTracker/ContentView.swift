//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ExpenseViewModel()

    @State private var newName = ""
    @State private var newAmount = ""

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
                        viewModel.addExpense(name: newName, amount: amount)
                        newName = ""
                        newAmount = ""
                    }
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()

            List {
                ForEach(viewModel.expenses) { expense in
                    HStack {
                        Text(expense.name)
                        Spacer()
                        Text("₺\(expense.amount, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: viewModel.deleteExpense)
            }
            
            Text("Toplam: ₺\(viewModel.totalAmount(), specifier: "%.2f")")
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
