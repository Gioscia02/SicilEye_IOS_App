//
//  Attraction.swift
//  PanormusLens
//
//  Created by Samuele Lo Cascio on 05/07/24.
//

import Foundation
import CoreLocation

struct Attraction: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    var x_cord: Double
    var y_cord: Double
    var storia: String
    var arte: String
    var curiosita: String
    var image: String
    
    func distance(from location: CLLocation) -> CLLocationDistance {
        let attractionLocation = CLLocation(latitude: x_cord, longitude: y_cord)
        return location.distance(from: attractionLocation)
    }
}
