//
//  ConvertService.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//

import Foundation
class ConvertService {
    
    static var shared = ConvertService()
    
    public func temperatureUsingSavedSetting(temperature: Double) -> String {
        var result: String = ""
        if UserDefaults.standard.string(forKey: "temperature") == "C" {
            result = "\(Int(temperature))\u{00B0}"
        } else {
            result = "\(Int((temperature * 9 / 5) + 32))\u{00B0}"
        }
        return result
    }
    
    public func windSpeedUsingSavedSettings(windSpeed: Int16) -> String {
        var result: String = ""
        if UserDefaults.standard.string(forKey: "windSpeed") == "Km" {
            result = "\(windSpeed) м\\c"
        } else {
            let windSpeed = Double(windSpeed) * 2.237
            result = "\(Int(windSpeed * 2.237)) миля\\ч"
        }
        return result
    }
    
    public func timeUsingSavedSettings(dateInSeconds: Double) -> String {
        let timeFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: "dateFormat") == "24" {
            timeFormatter.dateFormat = "HH:mm"
        } else {
            timeFormatter.dateFormat = "hh:mm"
        }
        let result = timeFormatter.string(from: Date(timeIntervalSince1970: dateInSeconds))
        return result
    }
    
    public func windDirection(from windDegree: Double) -> String {
        switch windDegree {
        case 0..<11.25:
            return "С"
        case 11.25..<33.75:
            return "ССВ"
        case 33.75..<56.25:
            return "СВ"
        case 56.25..<78.75:
            return "ВСВ"
        case 78.75..<101.25:
            return "В"
        case 101.25..<123.75:
            return "ВЮВ"
        case 123.75..<146.25:
            return "ЮВ"
        case 146.25..<168.75:
            return "ЮЮВ"
        case 168.75..<191.25:
            return "Ю"
        case 191.25..<213.75:
            return "ЮЮЗ"
        case 213.75..<236.25:
            return "ЮЗ"
        case 236.25..<258.75:
            return "ЗЮЗ"
        case 258.75..<281.25:
            return "З"
        case 281.25..<303.75:
            return "ЗСЗ"
        case 303.75..<326.25:
            return "СЗ"
        case 326.25..<348.75:
            return "ССЗ"
        case 348.75...380:
            return "ССЗ"
        default:
            return "н/о"
        }
    }
}
