//
//  ContentView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-18.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        
        //Checks if user navigates to HomeView or LoginView
        if db.currentUser != nil {
            NavigationStack {
                //Inloggad vy
                HomeView()
            }
        } else {
            //Utloggad vy
            NavigationStack {
                LoginView()
            }
        }
        

    }
}

#Preview {
    ContentView().environmentObject(DbConnection())
}
