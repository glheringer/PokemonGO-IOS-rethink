//
//  ViewController.swift
//  PokemonGO
//
//  Created by Rethink on 17/03/22.
//

import UIKit
import MapKit
class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager() //Manager que controla a localizacao do usuario no mapa
    var cont = 0
    var coreDataPokemon : CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    @IBOutlet weak var mapa: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configLocationManager()
        
        //Recuperar Pokemons e adicionar caso seja a primeira vez executada
        coreDataPokemon = CoreDataPokemon()
        self.pokemons = coreDataPokemon.listPokemons()
        
        //Exibir anotacoes aleatorias, que futuramente serao os pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in //timeInterval é dado em segundos
            if let coordinates = self.locationManager.location?.coordinate{

                // primeiro gerar um indice de pokemons aleatorios no array de pokemons
                let indexUInt32 = UInt32(self.pokemons.count)
                let randomPokemonsIndex =  arc4random_uniform(indexUInt32)
                let randomPokemon = self.pokemons[Int(randomPokemonsIndex)]
                                                  
                let annotation = PokemonAnnotation(coordinate: coordinates , pokemon: randomPokemon)
                
                let randomLatitude = (Double( arc4random_uniform(200) ) - 100.0) / 50000.0
                let randomLongitude = (Double( arc4random_uniform(200) ) - 100.0) / 50000.0
                
                annotation.coordinate.latitude += randomLatitude
                annotation.coordinate.longitude += randomLongitude
                
                self.mapa.addAnnotation(annotation)
            }
        }
    }
    //funcao que executa cada vez que uma anotacao é inserida
        // o parametro annotation dessa class é o mesmo que fizemos no viewDidLoad, mas recuperado
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //essa classe nao tem como passar um outro parametro para crianca de varias anotacoes ao mesmo tempo, necessaria alguma forma de corrigir  isso, criando uma anotacao que contenha Pokemons dentro, la no viewDidLoad

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            
            let image = UIImage(named: "player")
            annotationView.image = image
        }
        else{
            let pokemon = (annotation as! PokemonAnnotation).pokemon
            let image = UIImage(named: pokemon.imageName! )
            annotationView.image = image
        }
        
        //Configurar tamanho da imagem, se configura o frame, que é o que cerca imagem, como a moldura de um quadro
        var frame = annotationView.frame
        frame.size.height = 40
        frame.size.width = 40
        annotationView.frame = frame
        
        return annotationView
    }
    // Configuracoes Inicias do projeto
    func configLocationManager(){
        self.mapa.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //Metodo para centralizar a tela na localizacao do usuario de tempos em tempos
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if cont < 3 {
            
            self.centralize()
            cont += 1
        }
        else{
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Configurar quando o usuário nega autorizacao
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        if status != .authorizedWhenInUse && status != .authorizedAlways && status != .notDetermined{
            let alertController = UIAlertController(title: "Pemissao para Localizacao", message: "Para Capturar Pokemons é necessário a permissao para acesso â localizacao", preferredStyle: .alert)
            let actionCancell = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
            let actionSettings = UIAlertAction(title: "Abrir Configuracoes", style: .default) { (actionSettings) in
                if let acessSettings = NSURL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(acessSettings as URL)
                }
            }
            alertController.addAction(actionSettings)
            alertController.addAction(actionCancell)
            present(alertController, animated: true, completion: nil)
        }
    }
    //Funcao centralizar em si, criada para ser usada em mais de um lugar, reaproveitar codigo
    func centralize(){
        if let coordinate =  locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init( center: coordinate, latitudinalMeters: 320, longitudinalMeters: 320)
            mapa.setRegion(region, animated: true)
           
        }
    }
    // Centralizar na posicao do usuario
    @IBAction func alignCenterPlayer(_ sender: Any) {
        self.centralize()
    }
    //Abrir Pokedex
    @IBAction func openPokedex(_ sender: Any) {
    }
            
}

