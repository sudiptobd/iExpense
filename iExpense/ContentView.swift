//
//  ContentView.swift
//  iExpense
//
//  Created by Sudipto Roy on 7/19/25.
//

import Observation
import SwiftUI

struct User: Codable {
    var firstName = "Sudipto"
    var lastName = "Roy"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    var name: String = "Sudipto"
    var body: some View {
        Text(name)
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense: ObservableObject {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expense()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) {
                    Text($0.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
