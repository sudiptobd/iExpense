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
    @AppStorage("tap") private var tapCount = 0
    
    var body: some View {
        Button("Tap Count \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "tap")
        }
    }
}

#Preview {
    ContentView()
}
