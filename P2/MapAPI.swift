//
//  MapAPI.swift
//  PracticalPrototpye
//
//  Created by Mike Spears on 2019-05-13.
//  Copyright © 2019 Mike Spears. All rights reserved.
//

import Foundation
import MapKit

// set this to the valid root url for your api server
// e.g. let rootUrl = URL(string: "https://random-name.glitch.me")!
// (otherwise the app will crash here)
let rootUrl = URL(string: "")!

// To assign an object as the MapAPI delegate (to receive updated data when it is retrieved), the object must conform to the
// MapAPIDelegate protocol, and implement the dataRefreshed method defined here.
protocol MapAPIDelegate : class {
    func dataRefreshed(newData: [MapLocation]) -> Void
}

class MapAPI {
    
    // The delegate variable is declared 'weak' so that MapAPI doesn't take ownership or responsibility for disposing of the delegate object.
    weak var delegate: MapAPIDelegate?
    
    
    func updateLocations() {
        let customRequest = URLRequest(url: rootUrl.appendingPathComponent("getLocations"))
        URLSession.shared.dataTask(with: customRequest) { (data, response, error) in
            if let d = data {
                let newLocations = try! JSONDecoder.init().decode([MapLocation].self, from: d)
                DispatchQueue.main.async {
                    self.delegate?.dataRefreshed(newData: newLocations)
                }
            }
            }.resume()
    }
    
    func connect() {
        self.updateLocations()
    }
    
    func postLocation(location: MapLocation) {
        var customRequest = URLRequest(url: rootUrl.appendingPathComponent("addLocation"))
        customRequest.httpMethod = "POST"
        customRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        customRequest.httpBody = try! JSONEncoder.init().encode(location)
        
        URLSession.shared.dataTask(with: customRequest) {(data, response, error) in
            DispatchQueue.main.async {
                self.updateLocations()
            }
            }.resume()
    }
    
    func updateLocation(location: MapLocation) {
        var customRequest = URLRequest(url: rootUrl.appendingPathComponent("updateLocation"))
        customRequest.httpMethod = "POST"
        customRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        customRequest.httpBody = try! JSONEncoder.init().encode(location)
        
        URLSession.shared.dataTask(with: customRequest) {(data, response, error) in
            DispatchQueue.main.async {
                self.updateLocations()
            }
            }.resume()
    }
    
    func deleteLocation(location: MapLocation) {
        var customRequest = URLRequest(url: rootUrl.appendingPathComponent("deleteLocation"))
        customRequest.httpMethod = "POST"
        customRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        customRequest.httpBody = try! JSONEncoder.init().encode(location)
        
        URLSession.shared.dataTask(with: customRequest) {(data, response, error) in
            DispatchQueue.main.async {
                self.updateLocations()
            }
            }.resume()
    }
    
}
