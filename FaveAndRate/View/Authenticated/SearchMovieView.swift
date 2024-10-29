//
//  SearchMovieView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-28.
//

import SwiftUI

struct SearchMovieView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var movieManager: MovieManager
    
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                ForEach(movieManager.movies, id: \.id) { movie in
                    
                    MovieCard(movie: movie)
                }
            }
            .searchable(text: $movieManager.userInput, prompt: "Search movies")
            .onChange(of: movieManager.userInput) {
                Task {
                    do {
                        try await movieManager.searchMovies()
                    } catch {
                        print("Error fetching movies: \(error)")
                    }
                }
            }
            
        }
        
        
    }
}

#Preview {
    SearchMovieView().environmentObject(DbConnection()).environmentObject(MovieManager())
}
