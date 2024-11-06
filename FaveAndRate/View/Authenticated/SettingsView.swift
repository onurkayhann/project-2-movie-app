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
                            Image(systemName: "person.circle").foregroundStyle(.customBlack)
                            Text("Edit Profile").foregroundStyle(.customBlack)
                        })
                        
                    }
                    
                    HStack {
                        NavigationLink(destination: ProfileView(), label: {
                            Image(systemName: "plus.rectangle.portrait").foregroundStyle(.customBlack)
                            Text("Your Watchlist").foregroundStyle(.customBlack)
                        })
                        
                    }
                    
                    HStack {
                        NavigationLink(destination: AboutView(), label: {
                            Image(systemName: "info.circle").foregroundStyle(.customBlack)
                            Text("About Us").foregroundStyle(.customBlack)
                        })
                    }
                    
                    HStack {
                        NavigationLink(destination: ContactView(), label: {
                            Image(systemName: "envelope").foregroundStyle(.customBlack)
                            Text("Contact").foregroundStyle(.customBlack)
                        })
                    }
                    
                    HStack {
                        Image(systemName: "moon").foregroundStyle(.customBlack)
                        Text("Dark Mode").foregroundStyle(.customBlack)
                        // Toggle(isOn: <#T##Binding<Bool>#>, label: <#T##() -> Label#>)
                    }
                    
                    HStack {
                        
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .foregroundStyle(.logout)
                        Text("Logout")
                            .foregroundStyle(.logout)
                        
                    }.onTapGesture {
                        db.signOut()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(DbConnection()).environmentObject(MovieManager())
}
