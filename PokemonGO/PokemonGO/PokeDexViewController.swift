//
//  PokeDexViewController.swift
//  PokemonGO
//
//  Created by Rethink on 18/03/22.
//

import UIKit

class PokeDexViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var catchedPokemons : [Pokemon] = []
    var uncatchedPokemons : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  coreDataPokemon = CoreDataPokemon ()
        self.catchedPokemons = coreDataPokemon.listCatchedPokemons(isCatched: true)
        self.uncatchedPokemons = coreDataPokemon.listCatchedPokemons(isCatched: false)
        
        print(String(self.uncatchedPokemons.count))
    }
    func numberOfSections(in tableView: UITableView) -> Int { // agora em duas secoes, uma para capturados e uma nao capturados
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { //dividindo secoes
            return self.catchedPokemons.count
        }else{
            return self.uncatchedPokemons.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon : Pokemon
        if indexPath.section == 0 {
            
            pokemon = catchedPokemons[indexPath.row]
            
        }else{
            
            pokemon = uncatchedPokemons[indexPath.row]
            
        }
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "reuseCell")
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        return cell
    }
    
    @IBAction func backToMap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
