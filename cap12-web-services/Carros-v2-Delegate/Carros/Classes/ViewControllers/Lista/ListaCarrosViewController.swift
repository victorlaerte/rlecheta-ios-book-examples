//
//  ListaCarrosViewController.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/11/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var progress : UIActivityIndicatorView!
    
    var carros: Array<Carro> = []
    
    // Tipo do carro
    var tipo = "classicos"
    
    override init() {
        super.init(nibName: "ListaCarrosViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Título
        self.title = "Carros"
        
        // delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Para o scroll começar na posição do TableView
        self.automaticallyAdjustsScrollViewInsets = false;
        
        // Registra o CarroCell.xib como UITableViewCell da tabela
        let xib = UINib(nibName: "CarroCell", bundle:nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        // Botao Refresh na navigation bar
        let btAtualizar = UIBarButtonItem(title: "Atualizar", style: UIBarButtonItemStyle.Bordered, target: self, action: "atualizar")
        self.navigationItem.rightBarButtonItem = btAtualizar
        
        // Busca carros
        self.buscarCarros()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Se a variável opcional está inicializada, retorna a quantidade de carros
        return self.carros.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cria a célula desta linha
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as CarroCell
        
        let linha = indexPath.row
        
        // Objeto do tipo carro
        let carro = self.carros[linha]
        
        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc
        
        println("url \(carro.url_foto)")
        cell.cellImg.setUrl(carro.url_foto, cache: true)
        
        // Busca a imagem (problema de performance aqui)
//        let data = NSData(contentsOfURL: NSURL(string: carro.url_foto)!)
//        if(data != nil) {
//            let image = UIImage(data: data!)
//            cell.cellImg.image = image
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let linha = indexPath.row
        
        let carro = self.carros[linha]
        
        //        Alerta.alerta("Selecionou o carro: " + carro.nome, viewController: self)
        
        let vc = DetalhesCarroViewController()
        vc.carro = carro
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    override func supportedInterfaceOrientations() -> Int  {
        // Apenas vertical
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    @IBAction func alterarTipo(sender: UISegmentedControl) {
        var idx = sender.selectedSegmentIndex
        
        switch (idx) {
        case 0:
            self.tipo = "classicos"
        case 1:
            self.tipo = "esportivos"
        default:
            self.tipo = "luxo"
        }
        
        // Buscar os carros pelo tipo selecionado (classico, esportivo, luxo)
        self.buscarCarros()
    }
    
    func atualizar() {
        buscarCarros()
    }
    
    func buscarCarros() {

        progress.startAnimating()
        
        var funcaoRetorno = { (carros: Array<Carro>!, error: NSError!) -> Void in
            
            if(error != nil) {
                
                Alerta.alerta("Erro: " + error.localizedDescription, viewController: self)
                
            } else {
                
                self.carros = carros
                
                // Atualiza o TableView
                self.tableView.reloadData()
                
                self.progress.stopAnimating()
            }
        }
        
        CarroService.getCarrosByTipo(tipo, callback:funcaoRetorno)
    }
}
