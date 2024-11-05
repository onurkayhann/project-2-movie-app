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
        
        /*let filteredMovies = retrievedMovies.description.filter { movie in
                // Check that the movie's title does not contain "Extended"
                !movie.title.lowercased().contains("extended")
            }
         */
        
        DispatchQueue.main.async {
            self.upcomingMovies = retrievedMovies.description
        }
        
    }
    
    func getTopRankedMovies() async throws {
        let retrievedMovies: MovieResponse = try await api.get(url: "\(BASE_URL)/search?q=harry_potter")
        
        DispatchQueue.main.async {
            self.topRankedMovies = retrievedMovies.description
        }
        
    }
    /*
    func upcomingMovies() async throws {
        let movieIds = ["tt9218128", "tt13622970", "tt0468569", "tt14948432", "tt13186482"]
            
            // Create an array to hold the retrieved ApiMovies
            var retrievedApiMovies: [ApiMovie] = []

            // Fetch each movie by its ID using a single API call if your API allows batch fetching
            for id in movieIds {
                let movieResponse: MovieResponse = try await api.get(url: "\(BASE_URL)/search?tt=\(id)")
                
                // Assuming movieResponse.description is where your movie data resides
                retrievedApiMovies.append(contentsOf: movieResponse.description)
            }

            // Update the movies property on the main thread
            DispatchQueue.main.async {
                self.movies = retrievedApiMovies
            }
    }
    */
    
    /*
    func topRankedMovies() async throws {
        let movieIds = ["tt0111161", "tt0068646", "tt0468569", "tt0071562", "tt0050083"]

            // Create an array to hold the retrieved ApiMovies
            var retrievedApiMovies: [ApiMovie] = []

            // Fetch each movie by its ID
            for id in movieIds {
                let movieResponse: MovieResponse = try await api.get(url: "\(BASE_URL)/search?tt=\(id)")
                // Assuming movieResponse.description contains the array of ApiMovie
                retrievedApiMovies.append(contentsOf: movieResponse.description)
            }

            // Update the movies property on the main thread
            DispatchQueue.main.async {
                self.movies = retrievedApiMovies
            }
    }
    */
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
