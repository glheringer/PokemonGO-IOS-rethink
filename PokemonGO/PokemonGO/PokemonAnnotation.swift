//
//  PokemonAnnotation.swift
//  PokemonGO
//
//  Created by Rethink on 18/03/22.
//

import Foundation
import MapKit

class PokemonAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    init(coordinate : CLLocationCoordinate2D , pokemon : Pokemon){
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
}
