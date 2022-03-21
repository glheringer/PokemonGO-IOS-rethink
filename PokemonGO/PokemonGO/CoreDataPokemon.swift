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
        
        let context = getContext()
        
        self.createPokemon(name: "Pikachu", imageName: "pikachu-2", catched: true)
        self.createPokemon(name: "Mew", imageName: "mew", catched: false)
        self.createPokemon(name: "Bullbasaur", imageName: "bullbasaur", catched: false)
        self.createPokemon(name: "Squirtle", imageName: "squirtle", catched: false)
        self.createPokemon(name: "Caterpie", imageName: "caterpie", catched: false)
        self.createPokemon(name: "Charmander", imageName: "charmander", catched: false)
        self.createPokemon(name: "Bellsprout", imageName: "bellsprout", catched: false)
        self.createPokemon(name: "Meowth", imageName: "meowth", catched: false)
        self.createPokemon(name: "Psyduck", imageName: "psyduck", catched: false)
        self.createPokemon(name: "Rattata", imageName: "rattata", catched: false)
        self.createPokemon(name: "Snorlax", imageName: "snorlax", catched: false)
        self.createPokemon(name: "Zubat", imageName: "zubat", catched: false)
        self.createPokemon(name: "Jigglypuff", imageName: "jigglypuff", catched: false)
        
        do {
            try context.save()
        } catch  {
            
        }
    }
    // criar pokemons
    func createPokemon(name : String , imageName : String , catched : Bool ){
        let context  = getContext()
        let pokemon = Pokemon(context: context)
        pokemon.name = name
        pokemon.imageName = imageName
        pokemon.catched = catched
    
    }
    func listPokemons () -> [Pokemon] {
       let context =  self.getContext()
        
        do {
            let pokemons =  try context.fetch(Pokemon.fetchRequest()) as [Pokemon]
            if pokemons.count == 0 {
                
                self.addAllPokemons()
                return self.listPokemons()
        
            }
            return pokemons
        } catch  {
            
        }
        return []
    }
    func listCatchedPokemons(isCatched : Bool ) -> [Pokemon] {
       
        let context = self.getContext()
      
        let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        
//        let predicate = NSPredicate(format: "catched ==  %@", isCatched as CVarArg )
        
//        request.predicate  = NSPredicate(format: "%catched == %@", NSNumber(value: isCatched))
        if isCatched == true{
            request.predicate = NSPredicate(format: "catched = %d", true)
        }
        else{
            request.predicate = NSPredicate(format: "catched = %d", false)
        }
        

        do{
            let pokemons = try context.fetch( request ) as [Pokemon]
            return pokemons
            
        }catch{}
        
        return []
    }
    func catchPokemon(pokemon : Pokemon){
        
        let context =  self.getContext()
        
        pokemon.catched = true
        
        do {
            try context.save()
        } catch  {
            
        }
    }
    
}
