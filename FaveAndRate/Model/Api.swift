//
//  Api.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-23.
//

import Foundation

class Api {
    
    func get<R: Decodable>(url: String) async throws -> R {
        
        guard let url = URL(string: url) else { throw APIErrors.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 205 else { throw APIErrors.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            
            let decodedResponse = try decoder.decode(R.self, from: data)
            
            return decodedResponse
        } catch {
            
            throw APIErrors.invalidData
        }
        
    }
    
    
}

//error handler
enum APIErrors: Error {
    
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidRequest
    
}
