//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import Foundation
// MARK: - ForcastModel
struct ForecastModel: Codable {
    let lat: Double
    let lon: Double
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case current
        case hourly
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt: Double
    let temp: Double
    let feelsLike: Double
    let clouds: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let pop: Double

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case clouds
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, pop
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Double
    let moonset: Double
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let humidity: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let uvi: Double
    let rain: Double?
    let snow: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, pop, uvi, rain, snow
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night: Double
    
    enum CodingKeys: String, CodingKey {
        case day, night
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night
    }
}

// MARK: - Weather
struct Weather: Codable {
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}
