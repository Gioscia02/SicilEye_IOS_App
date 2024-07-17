//
//  ModelData.swift
//  PanormusLens
//
//  Created by Samuele Lo Cascio on 05/07/24.
//

import Foundation
import CoreLocation

var attractions: [Attraction] = load("attractions.json")

var currentLocation: CLLocation?

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        let res = try decoder.decode(T.self, from: data)
        sortAttractionsByDistance()
        return res
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
    
}



// Funzione per ordinare le attrazioni in base alla distanza dalla posizione corrente
func sortAttractionsByDistance() {
    guard let currentLocation = currentLocation else {
        // Gestire il caso in cui la posizione corrente non sia disponibile
        return
    }
    
    attractions.sort { attraction1, attraction2 in
        let distance1 = attraction1.distance(from: currentLocation)
        let distance2 = attraction2.distance(from: currentLocation)
        
        return distance1 < distance2
    }
}


