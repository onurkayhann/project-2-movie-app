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

struct MovieEntry: Codable {
    
    var description: [Moviedescription]
    
    enum CodingKeys: String, CodingKey {
        case description
    }
    
}
    
struct Moviedescription: Codable, Identifiable {
        
        var id: String?
        var title: String?
        var year: String?
        
        enum CodingKeys: String, CodingKey {
            
            case id = "#IMDB_ID"
            case title = "#TITLE"
            case year = "#YEAR"
            // add more movie description later
            
        }
    }
    
