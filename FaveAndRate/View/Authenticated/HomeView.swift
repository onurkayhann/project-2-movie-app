//
//  HomeView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        VStack {
            Text("Welcome, \(db.currentUserData?.name ?? "No user found")!")
            
            Button("Logout", action: {
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
        .padding()
    }
}

#Preview {
    HomeView().environmentObject(DbConnection())
}
