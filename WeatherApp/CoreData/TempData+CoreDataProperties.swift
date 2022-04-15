//
//  TempData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//
//

import Foundation
import CoreData


extension TempData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TempData> {
        return NSFetchRequest<TempData>(entityName: "TempData")
    }

    @NSManaged public var day: Double
    @NSManaged public var max: Double
    @NSManaged public var min: Double
    @NSManaged public var night: Double
    @NSManaged public var daily: DailyData

}

extension TempData : Identifiable {

}
