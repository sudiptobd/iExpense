//
//  AddView.swift
//  iExpense
//
//  Created by Sudipto Roy on 7/20/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State var amount = 0.0
    @State var name = ""
    @State var type = "Personal"
    var expense: Expense
    
    let types = ["Business", "Personal", "Savings"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expense.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expense: Expense())
}
