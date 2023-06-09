//
//  ContentView.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 01.04.23.
//

import SwiftUI
import PMDesignSystem

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(PMDesignSystem().text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
