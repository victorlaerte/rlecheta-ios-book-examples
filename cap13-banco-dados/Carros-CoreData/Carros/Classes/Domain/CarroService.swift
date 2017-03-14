//
//  CarroService.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/12/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class CarroService {
    
    class func getCarrosByTipo(tipo: String, cache:Bool, callback: (carros:Array<Carro>!, error:NSError!) -> Void) {
        
        var db = CarroDBCoreData()
        
        // Busca os carros do banco de dados
        var carros : Array<Carro> = cache ? db.getCarrosByTipo(tipo) : []
        
        // Se existir no banco de dados retorna
        if(carros.count > 0) {
            db.close()
            // Retorna os carros pela função de retorno
            callback(carros:carros, error: nil)
            println("Retornando \(carros.count) carros \(tipo) do banco")
            return
        }
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string:"http://www.livroiphone.com.br/carros/carros_"+tipo+".json")
        if(url != nil) {
            println(url)
            let task = http.dataTaskWithURL(url!, completionHandler: {
                (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if(error != nil || data == nil) {
                    callback(carros:nil, error: error)
                } else {
                    
                    if(data != nil) {
                        // Deleta antes de fazer parser no CoreData
                        db.deleteCarrosTipo(tipo)
                        
                        let carros = CarroService.parserJson(data)
                        
                        if(carros.count > 0) {

                            for c in carros {
                                // Salva o tipo do carro
                                c.tipo = tipo
                                // Salva o carro no banco
                                db.save(c)
                            }
                            db.close()
                        }
                        
                        println("carros \(carros.count)")
                        
                        dispatch_sync(dispatch_get_main_queue(), {
                            callback(carros:carros, error: nil)
                        })
                    }
                }
                
            })
            
            task.resume()
        }
    }

    
    // Busca por os carros pelo tipo: esportivos, clássicos ou luxo
    class func getCarrosByTipoFromFile(tipo: String) -> Array<Carro> {
        let file = "carros_" + tipo
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "xml")
        
        if(path == nil) {
            // Não encontrou o arquivo no projeto
            return [] // array vazio
        }
        
        // Conteúdo binário do arquivo
        let data = NSData(contentsOfFile: path!)
        
        if(data == nil) {
            // Não conseguiu ler o arquivo
            return [] // array vazio
        }
        
        if (data!.length == 0) {
            println("NSData vazio");
            return [] // array vazio
        }
        
        //let carros = self.parserJson(data!)
        
        let carros = parserXML_DOM(data!)
        
        for c in carros {
            // Atualiza o tipo do carro vamos precisar depois
            c.tipo = tipo
        }
        
        return carros
    }
    
    // Parser JSON
    class func parserJson(data: NSData) -> Array<Carro> {
        
        var carros : Array<Carro> = []
        
        // Faz a leitura do JSON, converte para dictionary
        var error: NSError?
        var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        // Dictionary para todos os carros
        var jsonCarros: NSDictionary = dict["carros"] as NSDictionary
        var arrayCarros: NSArray = jsonCarros["carro"] as NSArray
        
        // Array de carros
        for obj:AnyObject in arrayCarros {
            var dict = obj as NSDictionary
            var carro = CarroDBCoreData.newInstance()
            carro.nome = dict["nome"] as String
            carro.desc = dict["desc"] as String
            carro.url_info = dict["url_info"] as String
            carro.url_foto = dict["url_foto"] as String
            carro.url_video = dict["url_video"] as String
            carro.latitude = dict["latitude"] as String
            carro.longitude = dict["longitude"] as String
            carros.append(carro)
        }
        
        // Retorna a lista de carros
        return carros
    }
    
    // Parser de XML com DOM
    class func parserXML_DOM(data: NSData) -> Array<Carro> {
        var carros : Array<Carro> = []
        
        // Lê a tag raiz <carros>
        let document = SMXMLDocument(data: data, error:nil)
        
        if(document == nil) {
            println("Erro ao ler os dados");
            return carros
        }
        
        let root = document.root as SMXMLElement
        let tagCarros = root.childrenNamed("carro") as NSArray
        
        // Percorre todas as tags <carro>
        for x:AnyObject in  tagCarros {
            var xml = x as SMXMLElement
            
            var carro = CarroDBCoreData.newInstance()
            carro.nome = xml.valueWithPath("nome")
            carro.desc = xml.valueWithPath("desc")
            carro.url_info = xml.valueWithPath("url_info")
            carro.url_foto = xml.valueWithPath("url_foto")
            carro.url_video = xml.valueWithPath("url_video")
            if(xml.valueWithPath("latitude") != nil) {
                carro.latitude = xml.valueWithPath("latitude")
            }
            if(xml.valueWithPath("longitude") != nil) {
                carro.longitude = xml.valueWithPath("longitude")
            }
            
            carros.append(carro)
            
        }
        
        return carros
    }
    
    // Parser de XML com SAX
    class func parserXML_SAX(data: NSData) -> Array<Carro> {
        var carros : Array<Carro> = []
        
        let xmlParser = NSXMLParser(data:data)
        
        let carrosParser = XMLCarroParser()
        xmlParser.delegate = carrosParser
        
        // Inicia o parser com o NSXMLParser, o que vai chamar a classe XMLCarroParser
        let ok = xmlParser.parse()
        
        if (ok) {
            // Fez o parser com sucesso, retorna a lista de carros
            carros = carrosParser.carros
            
            var count = countElements(carros)
            
            println("Parser, encontrado \(count) carros");
            
        } else {
            println("Erro no parser");
        }
        
        // Retorna a lista de carros
        return carros
    }
    
    // Retorna um array de carros de forma simples
    class func getCarros() -> Array<Carro> {
        
        var carros : Array<Carro> = []
        
        for (var i = 0; i < 20; i++) {
            var c = Carro()
            c.nome = "Ferrari " + String(i)
            c.desc = "Desc Carro " + String(i)
            c.url_foto = "Ferrari_FF.png"
            c.url_info = "http://www.google.com.br"
            
            // Adiciona o carro no array
            carros.append(c)
        }
        
        return carros
    }
}