//
//  LocationManager.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static var shared = LocationManager()
    private let manager = CLLocationManager()
    private var completion: ((CLLocation)->Void)?
    private var changeAuthorizationCompletion: (() -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    public func startGetLocation(completion: @escaping () -> Void) {
        self.changeAuthorizationCompletion = completion
        manager.requestWhenInUseAuthorization()
    }
    
    public func getLocation() -> CLLocation? {
        if CLLocationManager.locationServicesEnabled() {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        return manager.location
    }
    
    public func isEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    return false
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                @unknown default:
                    return false
            }
            } else {
                return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if self.changeAuthorizationCompletion != nil {
                self.changeAuthorizationCompletion!()
            }
        default:
            return
        }
    }
}
