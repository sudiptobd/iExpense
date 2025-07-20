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

struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "user")
            }
        }
        
        Text("User is \(user.firstName) \(user.lastName)")
        
        Button("Load User") {
            if let data = UserDefaults.standard.data(forKey: "user") {
                let decoder = JSONDecoder()
                if var loadedUser = try? decoder.decode(User.self, from: data) {
                    loadedUser.firstName = "Sudipto"
                    user = loadedUser
                }
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
