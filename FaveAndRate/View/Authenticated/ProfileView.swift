//
//  ProfielView.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var movieManager: MovieManager
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: "https://www.shutterstock.com/shutterstock/photos/1009320268/display_1500/stock-vector-movie-time-vector-illustration-cinema-poster-concept-on-red-round-background-composition-with-1009320268.jpg"), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                VStack {
                    Text("Loading...").foregroundStyle(.black)
                }.background(.gray)
            }).frame(width: 100, height: 150, alignment: .center).clipShape(Circle()).overlay(
                Circle().stroke(Color.customRed, lineWidth: 4)
            )
            Text(db.currentUserData?.name ?? "No user found")
                .foregroundStyle(.customRed)
                .font(.title)
                .bold().padding(.top, -20)
        }
        
        VStack(spacing: 10) {
            
            
            VStack(alignment: .leading) {
                Text("Watchlist").padding(.horizontal, 10).foregroundStyle(.customRed)
                    .font(.title3)
                    .bold()
                if movieManager.movies.isEmpty {
                    ProgressView("Loading movies...")
                } else {
                    ScrollView(.horizontal) {
                        
                        HStack(spacing: 15) {
                            
                            if let watchlist = db.currentUserData?.watchlist {
                                ForEach(watchlist, id: \.self) { movieId in
                                    if let movie = movieManager.getWatchlist(by: movieId) {
                                        MovieCard(movie: movie)
                                    } else {
                                        Text("Movie not found")
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            VStack(alignment: .leading) {
                Text("Watchlist").padding(.horizontal, 10).foregroundStyle(.customRed)
                    .font(.title3)
                    .bold()
                if movieManager.movies.isEmpty {
                    ProgressView("Loading movies...")
                } else {
                    ScrollView(.horizontal) {
                        
                        HStack(spacing: 15) {
                            
                            if let watchlist = db.currentUserData?.watchlist {
                                ForEach(watchlist, id: \.self) { movieId in
                                    if let movie = movieManager.getWatchlist(by: movieId) {
                                        MovieCard(movie: movie)
                                    } else {
                                        Text("Movie not found")
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ProfielView().environmentObject(DbConnection()).environmentObject(MovieManager())
}
