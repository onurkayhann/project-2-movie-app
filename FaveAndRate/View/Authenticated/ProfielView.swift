//
//  ProfielView.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-25.
//

import SwiftUI

struct ProfielView: View {
    
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var movieManager: MovieManager
    
    var body: some View {
        
        VStack {
            Text(db.currentUserData?.name ?? "No user found")
                .foregroundStyle(.customRed)
                .font(.title)
                .bold()
            
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
