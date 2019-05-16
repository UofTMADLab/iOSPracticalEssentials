//
//  MapLocation.swift
//  PracticalPrototpye
//
//  Created by Mike Spears on 2019-05-13.
//  Copyright © 2019 Mike Spears. All rights reserved.
//

import Foundation
import MapKit


class MapLocation : NSObject, Codable, MKAnnotation {
    
    override var description: String {
        return "\(self.title ?? "null")\n\t(\(self.latitude), \(self.longitude))\n"
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.latitude = String(coordinate.latitude)
        self.longitude = String(coordinate.longitude)
        self.title = title
        self.subtitle = subtitle
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(latitude)!,
                                      longitude: Double(longitude)!)
    }
    
    var rowid: Int?
    var title: String?
    var subtitle: String?
    
    var latitude: String
    var longitude: String
    
    var value1: String?
    var value2: String?
    
}

