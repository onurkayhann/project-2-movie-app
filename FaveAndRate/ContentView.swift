//
//  ContentView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-18.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        if db.currentUser != nil {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                
                NavigationStack {
                    SearchMovieView()
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                
                NavigationStack {
                    AboutView()
                    
                }
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                
                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                
                NavigationStack {
                    ProfileView()
                }
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(DbConnection()).environmentObject(MovieManager())
}
