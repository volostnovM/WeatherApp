//
//  GeocodingModel.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import Foundation
struct GeocodingModel: Codable {
    
    let name: String
    let lat: Double
    let lon: Double
    let country: String

    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
        case country
    }
    
}
