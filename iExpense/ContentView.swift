//
//  ContentView.swift
//  iExpense
//
//  Created by Sudipto Roy on 7/19/25.
//

import Observation
import SwiftUI

@Observable
class User {
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

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) { number in
                        Text("Row \(number)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
        
    
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
