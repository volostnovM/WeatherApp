//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//

import Foundation
protocol LocationOutput{
    func updateForecast(forecast: ForecastData, completion: @escaping (ForecastData) -> Void)
    func getCurrentData(for forecast: ForecastData, completion: @escaping (CurrentData) -> Void)
    func getHourlyData(for forecast: ForecastData, completion: @escaping ([HourlyData]) -> Void)
    func getDailyData(for forecast: ForecastData, completion: @escaping ([DailyData]) -> Void)
}

class LocationViewModel: LocationOutput {
    
    private let coreDataStack: CoreDataStack
    private let networkService: NetworkProtocol
    
    init(coreDataStack: CoreDataStack,
         networkService: NetworkProtocol) {
        self.networkService = networkService
        self.coreDataStack = coreDataStack
    }
    
    func updateForecast(forecast: ForecastData, completion: @escaping (ForecastData) -> Void) {
        var location = forecast.location
        var lat: Double = forecast.lat
        var lon: Double = forecast.lon
        if forecast.usingGeolacation {
            if let location = LocationManager.shared.getLocation() {
                lat = location.coordinate.latitude
                lon = location.coordinate.longitude
            }
            networkService.getCityFromCoordinates(latitude: lat, longitude: lon) { geocodingModel in
                location = geocodingModel.name
            }
        }
        networkService.getForecastFromNetwork(latitude: lat, longitude: lon) { [weak self] forecastModel in
            self?.coreDataStack.updateForecastData(what: forecast, with: forecastModel, location: location, completion: completion)
        }
    }
    
    func getCurrentData(for forecast: ForecastData, completion: @escaping (CurrentData) -> Void) {
        completion(coreDataStack.fetchCurrentData(for: forecast)[0])
    }
    
    func getHourlyData(for forecast: ForecastData, completion: @escaping ([HourlyData]) -> Void) {
        completion(coreDataStack.fetchHourlyData(for: forecast))
    }
    
    func getDailyData(for forecast: ForecastData, completion: @escaping ([DailyData]) -> Void) {
        completion(coreDataStack.fetchDailyData(for: forecast))
    }
    
}
