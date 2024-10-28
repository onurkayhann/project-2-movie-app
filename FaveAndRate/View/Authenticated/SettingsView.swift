//
//  SettingsView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-28.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        VStack {
            Text("Settings")
                .font(.title2).bold()
            Spacer()
            
            List() {
                HStack {
                    Image(systemName: "person.circle")
                    Text("Edit Profile")
                }
                
                HStack {
                    Image(systemName: "plus.rectangle.portrait")
                    Text("Your Watchlist")
                }
                
                HStack {
                    Image(systemName: "info.circle")
                    Text("About Us")
                }
                
                HStack {
                    Image(systemName: "envelope")
                    Text("Contact")
                }
                
                HStack {
                    Image(systemName: "moon")
                    Text("Dark Mode")
                    // Toggle(isOn: <#T##Binding<Bool>#>, label: <#T##() -> Label#>)
                }
                
            }
        }
        
    }
}

#Preview {
    SettingsView()
}

/*
    MARK: TODO
    - Maybe move SettingsView outside TabView or maybe move out About?
    - Do we really want Dark Mode/Light Mode toggle in here?
*/
