//
//  NetworkService.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import Foundation
protocol NetworkProtocol {
    func getForecastFromNetwork(latitude: Double, longitude: Double, completion: @escaping (ForecastModel) -> Void)
    func getCityFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (GeocodingModel) -> Void)
    func getCoordinatesFromCity(city: String, completion: @escaping (GeocodingModel) -> Void)
}

class NetworkService: NetworkProtocol {
    private let apiKey = "55e9e55adbc6997a7a5015c20fdd29c0"
    
    func getForecastFromNetwork(latitude: Double, longitude: Double, completion: @escaping (ForecastModel) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.openweathermap.org"
            components.path = "/data/2.5/onecall"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "exclude", value: "minutely,alerts"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "ru"),
                URLQueryItem(name: "appid", value: self.apiKey)
            ]
            guard let url = components.url else {
                return
            }
            self.getDataFromNet(url: url) { data in
                do {
                    let forecast = try JSONDecoder().decode(ForecastModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(forecast)
                    }
                } catch let error {
                    print("getForecastFromNetwork")
                    print(error)
                }
            }
        }
    }
    
    func getCityFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (GeocodingModel) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "api.openweathermap.org"
            components.path = "/geo/1.0/reverse"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "appid", value: self.apiKey)
            ]
            guard let url = components.url else {
                return
            }
            self.getDataFromNet(url: url) { data in
                do {
                    let location = try JSONDecoder().decode([GeocodingModel].self, from: data)
                    DispatchQueue.main.async {
                        completion(location[0])
                    }
                } catch let error {
                    print("getCityFromCoordinates")
                    print(error)
                }
            }
        }
    }
    
    func getCoordinatesFromCity(city: String, completion: @escaping (GeocodingModel) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "api.openweathermap.org"
            components.path = "/geo/1.0/direct"
            components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "limit", value: "1"),
                URLQueryItem(name: "appid", value: self.apiKey)
            ]
            guard let url = components.url else {
                return
            }
            self.getDataFromNet(url: url) { data in
                do {
                    let location = try JSONDecoder().decode([GeocodingModel].self, from: data)
                    DispatchQueue.main.async {
                        completion(location[0])
                    }
                } catch let error {
                    print("getCoordinatesFromCity")
                    print(error)
                }
            }
        }
    }
    
    private func getDataFromNet(url: URL, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, responce, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let httpResponce = responce as? HTTPURLResponse else {
                return
            }
            print("Responce status code: ", httpResponce.statusCode)
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
}
