//
//  Location+CoreDataClass.swift
//  MyLocations
//
//  Created by Wm. Zazeckie on 2/13/21.
//
//

import Foundation
import CoreData

// import to use MKAnnotation protocol
import MapKit

// @objc(Location) is telling the compiler that Location is the name Objective-C will use to refer to this class
// important since via name mangling does not mix well with Objective-C, which can be the case for hybrid projects = objc/swift applications
@objc(Location)

// the MKAnnotation protocol requires the class to implement the cooridnate property which is where these three variables come into play
public class Location: NSManagedObject, MKAnnotation {
    // all three variables are read-only computer properties, they cant be assigned values, however, they perform the logic from their code blocks
    // they only return a value, they compute something.
    
    
    public var coordinate: CLLocationCoordinate2D {
        
      return CLLocationCoordinate2DMake(latitude, longitude)
        
    }
    
    
    public var title: String? {
        
    if locationDescription.isEmpty {
        return "(No Description)"
      }
    else {
        return locationDescription
      }
    }
    
    
    public var subtitle: String? {
      return category
    }
    
    
    
    // determines whether or not the Location object has a photo associated with it
    var hasPhoto: Bool {
        return photoID != nil
    }
    
    // computes the full URL for the jpeg file of the photo
    var photoURL: URL {
        assert(photoID != nil, "No photo ID set") // making sure photoID is not nil.
        let filename = "Photo-\(photoID!.intValue).jpg"
        return applicationDocumentsDirectory.appendingPathComponent(filename) // using global variable applicationDocumentsDirectory to get URL to the documents directory
        
    }
    // returns a UIIMage object by loading the image file
    var photoImage: UIImage? {
        return UIImage(contentsOfFile: photoURL.path)
    }
    
    // finds the ID of the Photo
    class func nextPhotoID() -> Int {
    let userDefaults = UserDefaults.standard
    let currentID = userDefaults.integer(forKey: "PhotoID") + 1
    userDefaults.set(currentID, forKey: "PhotoID")
    userDefaults.synchronize()
    return currentID
        
    }
    // this can be used to remove any file or folder. Will be used in LocationsViewController in tableView(_:commit:forRowAt:)
    func removePhotoFile() {
      if hasPhoto {
    do {
    try FileManager.default.removeItem(at: photoURL)
    } catch {
          print("Error removing file: \(error)")
        }
    } }

}
