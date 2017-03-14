//
//  ViewController.swift
//  HelloMapDirections
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet var textEndereco: UITextField!
    
    override init() {
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textEndereco.text = "Av Manoel Ribas, Mercês Curitiba Brasil"
    }

    // Método chamado para fazer o geocoding
    @IBAction func go() {
     
        let geoCoder = CLGeocoder()
        
        let endereco = textEndereco.text
        
        var completionHandler =
        {
            (placemarks:Array<AnyObject>!, error:NSError!) -> Void  in

            // Recupera a primeira localização
            let placemark = placemarks[0] as CLPlacemark
            let location = placemark.location
            
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            println("Lat: \(lat) / Lng: \(lng)")
            
            // Abre a URL (Para tra ar a rota, partindo do endere o digitado para o RJ)
            // Observe que o RJ está fixo no código para facilitar a leitura.
            let url = "https://maps.google.com/maps?saddr=\(lat),\(lng)&daddr=-22.951915,-43.21056"
            
            UIApplication.sharedApplication().openURL(NSURL(string:url)!)
            
        }
        
        geoCoder.geocodeAddressString(endereco, completionHandler:completionHandler)
    }
}

