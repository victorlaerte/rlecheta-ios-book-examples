//
//  CarroDBCoreData.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/4/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation
import CoreData

class CarroDBCoreData {

    class func newInstance () -> Carro {
        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        // Context para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext

        // Cria uma instância do Carro (inserindo no managed object context)
//println(context)
        
        var c = NSEntityDescription.insertNewObjectForEntityForName("Carro", inManagedObjectContext:context!) as Carro
        
        return c
    }
    
    func getCarrosByTipo(tipo: String) -> Array<Carro> {
    
        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Context para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext

        // Define a entidade utilizada para a consulta
        let entity = NSEntityDescription.entityForName("Carro", inManagedObjectContext:context!)

        // Cria a request com os filtros da consulta
        let request = NSFetchRequest()
        request.entity = entity
        
        // Buscar por tipo, where tipo=?
        //let query = NSPredicate(format:"tipo = " + tipo,nil)
        //request.predicate = query
        
        // Ordena a consulta por ‘timestamp’
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors

        // Executa a consulta
        var error: NSError? = nil

        let array = context!.executeFetchRequest(request, error: &error)
        if (array == nil) {
            // Tratar erros aqui
            println("Erro \(error)")
            return [] as Array<Carro>;
        }

//        println(array)
//        for c:AnyObject in array {
//            println(c.nome)
//        }

        return array as Array<Carro>
    }

    // Salva um novo carro ou atualiza se já existe id
    func save(carro: Carro) {

        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        // Context para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext

        // Seta o timestamp (como se fosse o id)
        //if (carro.timestamp == nil) {
        carro.timestamp = NSDate()
        //}
        
        // Salva o carro
        var error: NSError? = nil
        //println("salvando carro \(carro.nome)")
        let ok = context!.save(&error)
        //println("salvou carro")
        if (!ok) {
            // Tratar erros aqui
            println("Erro \(error)")
        }
        
//        println("Carro \(carro.nome) salvo com sucesso.")
    }
    
    // Deleta o carro
    func delete(carro: Carro) {
        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Context para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext
        
        context!.deleteObject(carro)
        
        var error: NSError? = nil
        let ok = context!.save(&error)

        if (!ok) {
            // Tratar erros aqui
            println("Erro \(error)")
        }
    }
    
    // Deleta todos os carros do tipo informado
    func deleteCarrosTipo(tipo: String) {
        // Consulta os carros por tipo
        let carros = getCarrosByTipo(tipo)
        
        // Deleta todos os carros
        for c in carros {
            self.delete(c)
        }
    }
    
    func close() {
        // Não faz nada
        // Deixei apenas porque o CarroDB do SQLite tinha o close()
    }
}