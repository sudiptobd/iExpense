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

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense: ObservableObject {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoded
                
            }
        }
        
    }
}

struct ContentView: View {
    @State private var expense = Expense()
    @State private var showAddExpense: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expense.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showAddExpense = true
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddView(expense: expense)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expense.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
