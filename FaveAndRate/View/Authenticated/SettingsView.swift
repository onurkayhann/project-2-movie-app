//
//  SettingsView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-28.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Settings")
                    .font(.title2).bold()
                Spacer()
                
                List() {
                    HStack {
                        NavigationLink(destination: EditProfileView(), label: {
                            Image(systemName: "person.circle")
                            Text("Edit Profile")
                        })
                        
                    }
                    
                    HStack {
                        NavigationLink(destination: ProfileView(), label: {
                            Image(systemName: "plus.rectangle.portrait")
                            Text("Your Watchlist")
                        })
                        
                    }
                    
                    HStack {
                        NavigationLink(destination: AboutView(), label: {
                            Image(systemName: "info.circle")
                            Text("About Us")
                        })
                    }
                    
                    HStack {
                        NavigationLink(destination: ContactView(), label: {
                            Image(systemName: "envelope")
                            Text("Contact")
                        })
                    }
                    
                    HStack {
                        Image(systemName: "moon")
                        Text("Dark Mode")
                        // Toggle(isOn: <#T##Binding<Bool>#>, label: <#T##() -> Label#>)
                    }
                                        
                    HStack {
                        
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .foregroundStyle(.red)
                        Text("Logout")
                            .foregroundStyle(.red)
                        
                    }.onTapGesture {
                        db.signOut()
                    }
                    
                    Button("Logout", action: {
                        //Signing out
                        db.signOut()
                    })
                    .bold()
                    .padding()
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                    .foregroundStyle(.white)
                    .background(.customRed)
                    .clipShape(.buttonBorder)
                    .padding()
                    
                }
                
            }
            
        }
    }
}

#Preview {
    SettingsView().environmentObject(DbConnection()).environmentObject(MovieManager())
}

/*
    MARK: TODO
    - Maybe move SettingsView outside TabView or maybe move out About?
    - Do we really want Dark Mode/Light Mode toggle in here?
    - Decide which Logout function/or Button we will use
*/
