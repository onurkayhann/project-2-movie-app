//
//  ApiModel.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-23.
//

import Foundation

struct LoginRequest: Encodable {
    var email: String
    var password: String
}

struct RegisterRequest: Encodable {
    var name: String
    var email: String
    var password: String
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
}

/*
struct MoviesWrapper: Decodable {
    var description: [MovieEntry]
}
 */

struct MovieResponse: Codable {
    var description: [Movie]
}
    
struct Movie: Codable, Identifiable {
        
        var id: String?
        var title: String
        var year: Int
        var poster: String
        
        enum CodingKeys: String, CodingKey {
            case id = "#IMDB_ID"
            case title = "#TITLE"
            case year = "#YEAR"
            case poster = "#IMG_POSTER"
            // add more movie description later
        }
    }

//Make a new struct to use for user adding movies/series to FireStore
    
