//
//  HomeView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-22.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var movieManager: MovieManager
    
    var body: some View {
        VStack {
            Text("Welcome ").font(.title) + Text(db.currentUserData?.name ?? "No user found")
                .foregroundStyle(.customRed)
                .font(.title)
                .bold()
            
            Spacer()
            
            // Display Top Ranked Movies
            Text("Some Movie Series you may like")
                .font(.headline)
                .padding(.top)
            
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    Text("Harry Potter")
                    HStack(spacing: 15) {
                        ForEach(movieManager.topRankedMovies) { movie in
                            NavigationLink(destination: AboutMovieView(movie: movie)) {
                                MovieCard(movie: movie)
                            }
                        }
                    }
                }
            }
            
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    Text("Lord of the Rings")
                    HStack(spacing: 15) {
                        ForEach(movieManager.upcomingMovies) { movie in
                            NavigationLink(destination: AboutMovieView(movie: movie)) {
                                MovieCard(movie: movie)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    try await movieManager.getTopRankedMovies()
                    try await movieManager.getUpcomingMovies()
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
