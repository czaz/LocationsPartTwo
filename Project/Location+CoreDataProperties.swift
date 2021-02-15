//
//  Location+CoreDataProperties.swift
//  MyLocations
//
//  Created by Wm. Zazeckie on 2/13/21.
//
//

import Foundation
import CoreData

// importing Core Location, allows us to change the placemark property's type from NSObject? to CLPlacemark? on line 27
import CoreLocation


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }
    // these properties are managed by Core Data as specified by the @NSManaged
    @NSManaged public var photoID: NSNumber?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date
    @NSManaged public var locationDescription: String
    @NSManaged public var category: String
    @NSManaged public var placemark: CLPlacemark?
    

    
    
    
}

extension Location : Identifiable {

}
