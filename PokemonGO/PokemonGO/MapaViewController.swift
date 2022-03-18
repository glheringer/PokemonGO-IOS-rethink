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
    
    @IBOutlet weak var mapa: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configLocationManager()
     
        //Exibir anotacoes aleatorias, que futuramente serao os pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in //timeInterval é dado em segundos
            if let coordinates = self.locationManager.location?.coordinate{
                
                let anotation = MKPointAnnotation()
                
                let randomLatitude = (Double( arc4random_uniform(200) ) - 100.0) / 50000.0
                let randomLongitude = (Double( arc4random_uniform(200) ) - 100.0) / 50000.0
                
                anotation.coordinate = coordinates
                anotation.coordinate.latitude += randomLatitude
                anotation.coordinate.longitude += randomLongitude
                
                self.mapa.addAnnotation(anotation)
            }
        }
    }
    //funcao que executa cada vez que uma anotacao é inserida
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            
            let image = UIImage(named: "player")
            annotationView.image = image
        }
        else{
            
            let image = UIImage(named: "pikachu-2")
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

