//
//  ForecastData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//
//

import Foundation
import CoreData


extension ForecastData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastData> {
        return NSFetchRequest<ForecastData>(entityName: "ForecastData")
    }

    @NSManaged public var lat: Double
    @NSManaged public var location: String
    @NSManaged public var lon: Double
    @NSManaged public var usingGeolacation: Bool
    @NSManaged public var current: CurrentData
    @NSManaged public var daily: NSSet
    @NSManaged public var hourly: NSSet

}

// MARK: Generated accessors for daily
extension ForecastData {

    @objc(addDailyObject:)
    @NSManaged public func addToDaily(_ value: DailyData)

    @objc(removeDailyObject:)
    @NSManaged public func removeFromDaily(_ value: DailyData)

    @objc(addDaily:)
    @NSManaged public func addToDaily(_ values: NSSet)

    @objc(removeDaily:)
    @NSManaged public func removeFromDaily(_ values: NSSet)

}

// MARK: Generated accessors for hourly
extension ForecastData {

    @objc(addHourlyObject:)
    @NSManaged public func addToHourly(_ value: HourlyData)

    @objc(removeHourlyObject:)
    @NSManaged public func removeFromHourly(_ value: HourlyData)

    @objc(addHourly:)
    @NSManaged public func addToHourly(_ values: NSSet)

    @objc(removeHourly:)
    @NSManaged public func removeFromHourly(_ values: NSSet)

}

extension ForecastData : Identifiable {

}
