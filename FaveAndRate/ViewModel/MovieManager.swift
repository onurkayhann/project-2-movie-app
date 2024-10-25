//
//  MovieManager.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-23.
//

import Foundation

class MovieManager: ObservableObject {
    
    let api = Api()
    
    @Published var movies: [Movie] = []
    
    let BASE_URL = "https://imdb.iamidiotareyoutoo.com"
    
    init() {
            Task {
                do {
                    try await getMovies()
                } catch {
                    print("Error loading movies: \(error.localizedDescription)")
                }
            }
        }
    
    func getMovies() async throws {
        
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?q=jönssonligan")
        
        DispatchQueue.main.async {
            self.movies = retrievedMovies.description
        }
        
    }
    
    func getWatchlist(by id: String) -> Movie? {
            return movies.first { $0.id == id }
        }
}
