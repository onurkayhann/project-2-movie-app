//
//  HomeView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    var user: UserData?
    
    var body: some View {
        VStack {
            Text("Welcome, \(user?.name ?? "No user found")!")
        }
        .padding()
    }
}

#Preview {
    HomeView(user: UserData(name: "John Doe", watchlist: []))
}
