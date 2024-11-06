//
//  MovieManager.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-23.
//

import Foundation

class MovieManager: ObservableObject {
    let api = Api()
    
    @Published var movies: [ApiMovie] = []
    @Published var userInput: String = ""
    
    @Published var upcomingMovies: [ApiMovie] = []
    @Published var topRankedMovies: [ApiMovie] = []
    @Published var suggestedMovies: [ApiMovie] = []
    
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
    
    func getUpcomingMovies() async throws {
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?q=lord_of_the_rings")
        
        DispatchQueue.main.async {
            self.upcomingMovies = retrievedMovies.description
        }
        
    }
    
    func suggestedMovies() async throws {
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?q=scream")
        
        DispatchQueue.main.async {
            self.suggestedMovies = retrievedMovies.description
        }
        
    }
    
    func getTopRankedMovies() async throws {
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?q=harry_potter")
        
        DispatchQueue.main.async {
            self.topRankedMovies = retrievedMovies.description
        }
        
    }
    
    func searchMovies() async throws {
        guard !userInput.isEmpty else {
            
            DispatchQueue.main.async {
                self.movies = []
            }
            return
        }
        
        print("User input: \(userInput)")
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?q=\(userInput)")
        
        DispatchQueue.main.async {
            self.movies = retrievedMovies.description
        }
    }
    
    func getMovieById(id: String) async throws {
        
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?tt=\(id)")
        
        DispatchQueue.main.async {
            self.movies = retrievedMovies.description
        }
    }
    
    func getWatchlist(by id: String) -> ApiMovie? {
        return movies.first { $0.id == id }
    }
}
