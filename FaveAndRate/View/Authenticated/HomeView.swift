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
        Text("Welcome ").font(.title) + Text(db.currentUserData?.name ?? "No user found")
            .foregroundStyle(.customRed)
            .font(.title)
            .bold()
        Spacer()
        
        VStack {
            
            ScrollView(.horizontal) {
                
                HStack(spacing: 15) {
                    ForEach(movieManager.movies) { movies in
                        NavigationLink(destination: AboutMovieView(movie: movies)) {
                            MovieCard(movie: movies)
                        }
                    }
                }
            }
            
            HStack {
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
    }
}

#Preview {
    HomeView().environmentObject(DbConnection()).environmentObject(MovieManager())
}
