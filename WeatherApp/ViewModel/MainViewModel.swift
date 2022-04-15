//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import Foundation
// MARK: -
protocol MainOutput {
    func downloadForecastFromDataBase(completion: @escaping ([ForecastData]) -> Void)
    func getForecastForNewLocation(for geocodingModel: GeocodingModel, usingGeolocation: Bool, completion: @escaping () -> Void)
    func getLocation(compeletion: @escaping (_ location: GeocodingModel) -> Void)
    func getForecastUsingGeolocation(completion: @escaping () -> Void)
}

// MARK: -
class MainViewModel: MainOutput {

    private var latitude: Double = 0
    private var longitude: Double = 0
    private let coreDataStack: CoreDataStack
    private let networkService: NetworkProtocol

    init(coreDataStack: CoreDataStack,
         networkService: NetworkProtocol) {
        self.coreDataStack = coreDataStack
        self.networkService = networkService
    }
    
    func downloadForecastFromDataBase(completion: @escaping ([ForecastData]) -> Void) {
        completion(coreDataStack.fetchForecastData())
    }

    func getForecastForNewLocation(for geocodingModel: GeocodingModel,
                                   usingGeolocation: Bool,
                                   completion: @escaping () -> Void) {
        networkService.getForecastFromNetwork(latitude: geocodingModel.lat,
                                              longitude: geocodingModel.lon) { [weak self] forecastModel in
            self?.coreDataStack.createNewForecastData(forecast: forecastModel,
                                                      location: geocodingModel.name,
                                                      usingGeolocation: usingGeolocation,
                                                      completion: completion)
        }
    }

    func getForecastUsingGeolocation(completion: @escaping () -> Void) {
        self.getLocation { [weak self] geocodingModel in
            self?.getForecastForNewLocation(for: geocodingModel, usingGeolocation: true, completion: completion)
        }
    }

    func getLocation(compeletion: @escaping (GeocodingModel) -> Void) {
        if LocationManager.shared.isEnabled(),
           let location = LocationManager.shared.getLocation() {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        networkService.getCityFromCoordinates(latitude: latitude, longitude: longitude) { location in
            compeletion(location)
        }
    }
}

