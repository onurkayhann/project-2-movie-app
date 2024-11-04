//
//  Office.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-28.
//

import Foundation
import CoreLocation

struct Office: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var location: Location
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
}
