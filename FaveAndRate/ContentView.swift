//
//  ContentView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Prepare NavigationStack to later add if it's LoginView or RegisterView that user navigates to
        NavigationStack {
            
            LoginView()
        }

    }
}

#Preview {
    ContentView()
}
