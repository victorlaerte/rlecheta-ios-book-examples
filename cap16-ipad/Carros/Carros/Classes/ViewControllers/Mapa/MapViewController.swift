//
//  MapViewController.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/27/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let locationManager = CLLocationManager()

    var carro: Carro?
    
    var pin = MKPointAnnotation()

    @IBOutlet var mapView : MKMapView!
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init() {
        super.init(nibName: "MapViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nome do carro
        self.title = carro!.nome

        // Solicitar a permissão do usuário
        locationManager.requestWhenInUseAuthorization()
        
        var lat = (self.carro!.latitude as NSString).doubleValue
        var lng = (self.carro!.longitude as NSString).doubleValue
        
        // Coordenada (latitude/longitude)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = MKCoordinateRegion(center: center, span: span)
        
        // Centraliza o mapa nesta coordenada
        self.mapView.setRegion(location, animated: true)
        
        // Configura o modo satélite
        self.mapView.mapType = MKMapType.Satellite
        
        // Adiciona o marcador no mapa
        pin.coordinate = location.center
        pin.title = "Fábrica \(self.carro!.nome)"
        self.mapView.addAnnotation(pin)
        
        // Delegate
        self.mapView.delegate = self
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        
        pinView.pinColor = MKPinAnnotationColor.Red
        pinView.canShowCallout = true
        
        let btPin = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIView
        pinView.rightCalloutAccessoryView = btPin
        
        // Retorna a view que será exibida ao usuário
        return pinView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!)
    {
        // Clicou no botão da view
        Alerta.alerta("Clicou no Marcador",viewController: self)
    }
}
