//
//  CoreDataPokemon.swift
//  PokemonGO
//
//  Created by Rethink on 17/03/22.
//

import UIKit
import CoreData

class CoreDataPokemon {
    //recuperar o context
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
    
        return context!
        
    }
    //adicionar todos pokemons
    func addAllPokemons (){
        self.createPokemon(name: "Mew", imageName: "mew", catched: false)
        self.createPokemon(name: "Bullbasaur", imageName: "bullbasaur", catched: false)
        self.createPokemon(name: "Squirtle", imageName: "squirtle", catched: false)
        self.createPokemon(name: "Caterpie", imageName: "caterpie", catched: false)
        self.createPokemon(name: "Charmander", imageName: "charmander", catched: false)
        self.createPokemon(name: "Bellsprout", imageName: "bellsprout", catched: false)
        self.createPokemon(name: "Meowth", imageName: "meowth", catched: false)
        self.createPokemon(name: "Psyduck", imageName: "psyduck", catched: false)
        self.createPokemon(name: "Ratata", imageName: "ratata", catched: false)
        self.createPokemon(name: "Snorlax", imageName: "snorlax", catched: false)
        self.createPokemon(name: "Zubat", imageName: "zubat", catched: false)
        self.createPokemon(name: "Jigglypuff", imageName: "jigglypuff", catched: false)
    }
    // criar pokemons
    func createPokemon(name : String , imageName : String , catched : Bool ){
        let context  = getContext()
        let pokemon = Pokemon(context: context)
        pokemon.name = name
        pokemon.imageName = imageName
        pokemon.catched = catched
    
    }
    
}
