//
//  MovieManager.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-23.
//

import Foundation

class MovieManager: ObservableObject {
    
    let api = Api()
    
    @Published var movies: [MovieEntry] = []
    
    let BASE_URL = "https://imdb.iamidiotareyoutoo.com"
    
    func getMovies() async throws {
        
        let retrievedMovies: [MovieEntry] = try await api.get(url: "\(BASE_URL)/search?q=jönssonligan")
        
        DispatchQueue.main.async {
            self.movies = retrievedMovies
        }
        
    }
}