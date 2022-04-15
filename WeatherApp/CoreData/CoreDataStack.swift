//
//  CoreDataStack.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//

import Foundation
import CoreData

class CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    func fetchForecastData() -> [ForecastData] {
        let request: NSFetchRequest<ForecastData> = ForecastData.fetchRequest()
        request.includesSubentities = false
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("Не удалось загрузить ForecastData")
        }
    }
    
    func fetchCurrentData(for forecast: ForecastData) -> [CurrentData] {
        let request: NSFetchRequest<CurrentData> = CurrentData.fetchRequest()
        let predicate = NSPredicate(format: "forecast == %@", forecast)
        request.predicate = predicate
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("Не удалось загрузить CurrentData")
        }
    }
    
    func fetchHourlyData(for forecast: ForecastData) -> [HourlyData] {
        let request: NSFetchRequest<HourlyData> = HourlyData.fetchRequest()
        let dateDescriptor = NSSortDescriptor(key: "dt", ascending: true)
        request.sortDescriptors = [dateDescriptor]
        let predicate = NSPredicate(format: "forecast == %@", forecast)
        request.predicate = predicate
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("Не удалось загрузить HourlyData")
        }
    }
    
    func fetchDailyData(for forecast: ForecastData) -> [DailyData] {
        let request: NSFetchRequest<DailyData> = DailyData.fetchRequest()
        let dateDescriptor = NSSortDescriptor(key: "dt", ascending: true)
        request.sortDescriptors = [dateDescriptor]
        let predicate = NSPredicate(format: "forecast == %@", forecast)
        request.predicate = predicate
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("Не удалось загрузить DailyData")
        }
    }

    func remove(forecastData: ForecastData) {
        viewContext.delete(forecastData)

        save(context: viewContext)
    }

    func createNewForecastData(forecast: ForecastModel,
                               location: String,
                               usingGeolocation: Bool,
                               completion: @escaping () -> Void) {
        let backgroundContext = newBackgroundContext()

        let newForecastData = ForecastData(context: backgroundContext)
        newForecastData.lat = forecast.lat
        newForecastData.lon = forecast.lon
        newForecastData.location = location
        newForecastData.usingGeolacation = usingGeolocation

        let newCurrentData = CurrentData(context: backgroundContext)
        newCurrentData.dt = forecast.current.dt
        newCurrentData.sunrise = forecast.current.sunrise
        newCurrentData.sunset = forecast.current.sunset
        newCurrentData.temp = forecast.current.temp
        newCurrentData.humidity = Int16(forecast.current.humidity)
        newCurrentData.windSpeed = Int16(forecast.current.windSpeed)

        let newCurrentWeather = WeatherData(context: backgroundContext)
        newCurrentWeather.weatherDescription = forecast.current.weather[0].weatherDescription
        newCurrentWeather.icon = forecast.current.weather[0].icon
        
        newCurrentData.weather = newCurrentWeather
        newForecastData.current = newCurrentData

        for hourly in forecast.hourly {
            let newHourlyData = HourlyData(context: backgroundContext)
            newHourlyData.dt = hourly.dt
            newHourlyData.temp = hourly.temp
            newHourlyData.feelsLike = hourly.feelsLike
            newHourlyData.clouds = Int16(hourly.clouds)
            newHourlyData.windSpeed = hourly.windSpeed
            newHourlyData.windDeg = Int16(hourly.windDeg)
            newHourlyData.pop = hourly.pop
            
            let newWeatherData = WeatherData(context: backgroundContext)
            newWeatherData.weatherDescription = hourly.weather[0].weatherDescription
            newWeatherData.icon = hourly.weather[0].icon
            
            newHourlyData.weather = newWeatherData
            newForecastData.addToHourly(newHourlyData)
        }
        
        for daily in forecast.daily {
            let newDailyData = DailyData(context: backgroundContext)
            newDailyData.dt = daily.dt
            newDailyData.sunrise = daily.sunrise
            newDailyData.sunset = daily.sunset
            newDailyData.moonrise = daily.moonrise
            newDailyData.moonset = daily.moonset
            newDailyData.moonPhase = daily.moonPhase
            newDailyData.humidity = Int16(daily.humidity)
            newDailyData.windSpeed = daily.windSpeed
            newDailyData.windDeg = Int16(daily.windDeg)
            newDailyData.clouds = Int16(daily.clouds)
            newDailyData.pop = daily.pop
            newDailyData.uvi = daily.uvi
            if daily.rain != nil {
                newDailyData.rain = Int16(daily.rain!)
            } else {
                newDailyData.rain = 0
            }
            if daily.snow != nil {
                newDailyData.snow = Int16(daily.snow!)
            } else {
                newDailyData.snow = 0
            }
            
            let newTempData = TempData(context: backgroundContext)
            newTempData.day = daily.temp.day
            newTempData.min = daily.temp.min
            newTempData.max = daily.temp.max
            newTempData.night = daily.temp.night
            newDailyData.temp = newTempData
            
            let newFeelsLikeData = FeelsLikeData(context: backgroundContext)
            newFeelsLikeData.day = daily.feelsLike.day
            newFeelsLikeData.night = daily.feelsLike.night
            newDailyData.feelsLike = newFeelsLikeData
            
            let newWeatherData = WeatherData(context: backgroundContext)
            newWeatherData.weatherDescription = daily.weather[0].weatherDescription
            newWeatherData.icon = daily.weather[0].icon
            
            newDailyData.weather = newWeatherData
            newForecastData.addToDaily(newDailyData)
        }
        backgroundContext.perform {
            do {
                try backgroundContext.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch let error {
                print(error)
            }
        }
        
    }
    
    func updateForecastData(what forecastData: ForecastData,
                            with forecastModel: ForecastModel,
                            location: String,
                            completion: @escaping (ForecastData) -> Void ) {
        let currentData = fetchCurrentData(for: forecastData)
        let hourlyData = fetchHourlyData(for: forecastData)
        let dailyData = fetchDailyData(for: forecastData)
        
        forecastData.setValue(location, forKey: "location")
        forecastData.setValue(forecastModel.lat, forKey: "lat")
        forecastData.setValue(forecastModel.lon, forKey: "lon")
        
        for value in currentData {
            value.setValue(forecastModel.current.dt, forKey: "dt")
            value.setValue(Int16(forecastModel.current.humidity), forKey: "humidity")
            value.setValue(forecastModel.current.sunrise, forKey: "sunrise")
            value.setValue(forecastModel.current.sunset, forKey: "sunset")
            value.setValue(forecastModel.current.temp, forKey: "temp")
            value.setValue(Int16(forecastModel.current.windSpeed), forKey: "windSpeed")
            value.weather.setValue(forecastModel.current.weather[0].icon, forKey: "icon")
            value.weather.setValue(forecastModel.current.weather[0].weatherDescription, forKey: "weatherDescription")
        }
        
        for (key, value) in hourlyData.enumerated() {
            value.setValue(forecastModel.hourly[key].dt, forKey: "dt")
            value.setValue(forecastModel.hourly[key].temp, forKey: "temp")
            value.setValue(forecastModel.hourly[key].feelsLike, forKey: "feelsLike")
            value.setValue(Int16(forecastModel.hourly[key].clouds), forKey: "clouds")
            value.setValue(forecastModel.hourly[key].windSpeed, forKey: "windSpeed")
            value.setValue(Int16(forecastModel.hourly[key].windDeg), forKey: "windDeg")
            value.setValue(forecastModel.hourly[key].pop, forKey: "pop")
            value.weather.setValue(forecastModel.hourly[key].weather[0].icon, forKey: "icon")
            value.weather.setValue(forecastModel.hourly[key].weather[0].weatherDescription, forKey: "weatherDescription")
        }
        
        for (key, value) in dailyData.enumerated() {
            value.setValue(forecastModel.daily[key].dt, forKey: "dt")
            value.setValue(forecastModel.daily[key].sunrise, forKey: "sunrise")
            value.setValue(forecastModel.daily[key].sunset, forKey: "sunset")
            value.setValue(forecastModel.daily[key].moonrise, forKey: "moonrise")
            value.setValue(forecastModel.daily[key].moonset, forKey: "moonset")
            value.setValue(forecastModel.daily[key].moonPhase, forKey: "moonPhase")
            value.temp.setValue(forecastModel.daily[key].temp.day, forKey: "day")
            value.temp.setValue(forecastModel.daily[key].temp.min, forKey: "min")
            value.temp.setValue(forecastModel.daily[key].temp.max, forKey: "max")
            value.temp.setValue(forecastModel.daily[key].temp.night, forKey: "night")
            value.feelsLike.setValue(forecastModel.daily[key].feelsLike.day, forKey: "day")
            value.feelsLike.setValue(forecastModel.daily[key].feelsLike.night, forKey: "night")
            value.setValue(Int16(forecastModel.daily[key].humidity), forKey: "humidity")
            value.setValue(forecastModel.daily[key].windSpeed, forKey: "windSpeed")
            value.setValue(Int16(forecastModel.daily[key].windDeg), forKey: "windDeg")
            value.setValue(Int16(forecastModel.daily[key].clouds), forKey: "clouds")
            value.setValue(forecastModel.daily[key].pop, forKey: "pop")
            value.setValue(forecastModel.daily[key].uvi, forKey: "uvi")
            if forecastModel.daily[key].rain != nil {
                value.setValue(forecastModel.daily[key].rain!, forKey: "rain")
            } else {
                value.setValue(0, forKey: "rain")
            }
            if forecastModel.daily[key].snow != nil {
                value.setValue(forecastModel.daily[key].snow!, forKey: "snow")
            } else {
                value.setValue(0, forKey: "snow")
            }
            value.weather.setValue(forecastModel.daily[key].weather[0].icon, forKey: "icon")
            value.weather.setValue(forecastModel.daily[key].weather[0].weatherDescription, forKey: "weatherDescription")
        }
        
        do {
            try viewContext.save()
            completion(forecastData)
        } catch let error {
            print(error)
        }
    }

    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
