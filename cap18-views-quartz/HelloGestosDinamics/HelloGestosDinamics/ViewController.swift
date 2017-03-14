//
//  ViewController.swift
//  HelloGestosDinamics
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollisionBehaviorDelegate {
    
    @IBOutlet var imagem : UIImageView!
    
    var animator : UIDynamicAnimator!
    
    var items: Array<AnyObject>!
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        // Array para passar no construtor das classes UIGravityBehavior/UICollisionBehavior
        items = [self.imagem!]
    }
    
    @IBAction func testeGravidade() {
        println("testeGravidade")
        
        let gravidade = UIGravityBehavior(items: self.items)
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.animator.addBehavior(gravidade)
    }


    @IBAction func testeGravidadeEColisao() {
        println("testeGravidadeEColisao")
        
        // Gravidade
        let gravidade = UIGravityBehavior(items: self.items)
        let colisao = UICollisionBehavior(items: self.items)
        colisao.translatesReferenceBoundsIntoBoundary = true
        colisao.collisionDelegate = self

        // Adiciona os comportamentos
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.animator.addBehavior(gravidade)
        self.animator.addBehavior(colisao)
    }
    
    func collisionBehavior(behavior: UICollisionBehavior!, beganContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying!, atPoint p: CGPoint) {
    
        // Início da Colisão: pinta a cor de fundo da imagem de verde, apenas para demonstrar que colidiu
        let view = item as UIView
        view.backgroundColor = UIColor.greenColor()
    }
    
    func collisionBehavior(behavior: UICollisionBehavior!, endedContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying!) {
        println("Fim da colisão")
    }
}

