//
//  FirstStartIndicator.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import Foundation
class FirstStartIndicator {
    
    static let shared = FirstStartIndicator()
    
    func isFirstStart() -> Bool {
        return !UserDefaults.standard.bool(forKey: "FirstStart")
    }
    
    func setNotFirstStart() {
        UserDefaults.standard.setValue(true, forKey: "FirstStart")
    }
}
