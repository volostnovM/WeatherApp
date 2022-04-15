//
//  WeatherData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var icon: String
    @NSManaged public var weatherDescription: String
    @NSManaged public var current: CurrentData
    @NSManaged public var dailly: DailyData
    @NSManaged public var hourly: HourlyData

}

extension WeatherData : Identifiable {

}
