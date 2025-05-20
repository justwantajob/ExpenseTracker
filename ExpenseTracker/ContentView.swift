//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Gurur on 20.05.2025.
//

import SwiftUI
import Charts

struct ContentView: View {
    @StateObject private var viewModel = ExpenseViewModel()

    @State private var selectedCategory: ExpenseCategory = .other
    @State private var newName = ""
    @State private var newAmount = ""
    
    func groupedExpenses() -> [(key: String, value: Double)] {
        Dictionary(grouping: viewModel.expenses, by: { $0.category.rawValue })
            .mapValues { $0.reduce(0, { $0 + $1.amount }) }
            .sorted { $0.key < $1.key }
    }

    var body: some View {
        VStack {
            VStack() {
                HStack {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                HStack {
                    TextField("Expense Name", text: $newName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Amount", text: $newAmount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        if let amount = Double(newAmount) {
                            viewModel.addExpense(name: newName, amount: amount, category: selectedCategory)
                            newName = ""
                            newAmount = ""
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding()

            List {
                ForEach(viewModel.expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(expense.category.rawValue)")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Text(expense.name)
                        }
                        Spacer()
                        Text("-₺\(expense.amount, specifier: "%.2f")")
                            .foregroundStyle(.red)
                    }
                }
                .onDelete(perform: viewModel.deleteExpense)
            }
            
            Chart {
                ForEach(groupedExpenses(), id: \.key) { category, total in
                    BarMark(
                        x: .value("Category", category),
                        y: .value("Total", total)
                    )
                    .foregroundStyle(by: .value("Category", category))
                }
            }
            .frame(height: 200)
            .padding()
            
            Text("Toplam: ₺\(viewModel.totalAmount(), specifier: "%.2f")")
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
