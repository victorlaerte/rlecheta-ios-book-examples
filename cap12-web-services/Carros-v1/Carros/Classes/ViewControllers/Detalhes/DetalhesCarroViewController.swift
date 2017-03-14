//
//  DetalhesCarroViewController.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/11/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController {
    
    @IBOutlet var img : DownloadImageView!
    @IBOutlet var tDesc : UITextView!
    
    var carro: Carro?
    
    override init() {
        super.init(nibName: "DetalhesCarroViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let c = carro {
            self.title = c.nome
            
            self.tDesc.text = c.desc;
            
            //var img = UIImage(named: c.url_foto)
            //self.img.image = img
        
            self.img.setUrl(c.url_foto, cache: true)
        }
    }
    
    // Controlar a troca de orientação (vertical/horizontal)
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        println("viewWillTransitionToSize \(size)")
        
        if(size.width > size.height) {
            println("Horizontal")
            tDesc.hidden = true
            
            // Horizontal: Esconde tudo
            self.tabBarController!.tabBar.hidden = true
            self.navigationController!.navigationBar.hidden = true
        } else {
            println("Vertical")
            
            // Vertical: Mostra tudo
            self.tabBarController!.tabBar.hidden = false
            self.navigationController!.navigationBar.hidden = false
            
            tDesc.hidden = false
        }
        
        // Atualiza o status da action bar
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
}
