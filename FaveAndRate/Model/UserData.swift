//
//  UserData.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-21.
//

import Foundation

struct UserData: Codable {

    var name: String
    var watchlist: [WatchlistMovie]
    var movieComment: [MovieComment]?
    
    
}

struct WatchlistMovie: Codable, Identifiable {
    
    var id: String?
    var title: String
    var year: Int?
    var poster: String
    var actors: String
    var rank: Int
    
    func toDictionary() -> [String: Any] {
            return [
                "id": id ?? "",
                "title": title,
                "year": year ?? 0,
                "poster": poster,
                "actors": actors,
                "rank": rank
            ]
        }
    
}

extension WatchlistMovie {
    func toApiMovie() -> ApiMovie {
        return ApiMovie(id: id, title: title, year: year, poster: poster, actors: actors, rank: rank)
    }
}

struct MovieComment: Codable, Identifiable {
    var id: String
    var userId: String
    var movieId: String
    var text: String
    var audioComment: String?
    var type: String
}

extension MovieComment {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "userId": userId,
            "movieId": movieId,
            "text": text,
        ]
    }
}
