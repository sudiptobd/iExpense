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
    @State private var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: user.firstName)
        }
        
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("First Name", text: $user.firstName)
            TextField("last Name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
