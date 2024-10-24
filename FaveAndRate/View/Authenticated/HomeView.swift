//
//  HomeView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var movieManager: MovieManager
    
    var body: some View {
        VStack {
            //Rendering users name, adding title design such as font
            Text("Welcome, \(db.currentUserData?.name ?? "No user found")!")

                
                ForEach(movieManager.movies) { movieDescription in
                    
                    VStack {
                        
                        Text("\(movieDescription.title) (\(movieDescription.year))")
                                .font(.headline)
                    }
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
        .padding()
        .onAppear {
                    Task {
                        do {
                            try await movieManager.getMovies()
                        } catch {
                            print("Error fetching movies: \(error)")
                        }
                    }
                }
        
        //Adding API here, such as movies in horizontal scrollview
        //Add navigation to MovieView
        //Add bottom tab view, such as home and settings
    }
}

#Preview {
    HomeView().environmentObject(DbConnection()).environmentObject(MovieManager())
}
