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
            HStack(spacing: 0) {
                Text("Welcome ").font(.title).foregroundStyle(.customBlack)
                Text(db.currentUserData?.name ?? "No user found")
                    .foregroundStyle(.customRed)
                    .font(.title)
                    .bold()
            }
            .padding(.top, 30)
            
            Spacer()
            
            Text("Some Movie Series you may like")
                .font(.headline)
                .padding(.top)
                .frame(alignment: .center)
            
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    HStack(spacing: 15) {
                        ForEach(movieManager.topRankedMovies) { movie in
                            NavigationLink(destination: AboutMovieView(movie: movie)) {
                                MovieCard(movie: movie)
                            }
                        }
                    }
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
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
