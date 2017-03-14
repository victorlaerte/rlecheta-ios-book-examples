//
//  main.swift
//  OlaSwift
//
//  Created by Ricardo Lecheta on 8/19/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

println("Hello, World!")

func testeVar() {

    var a:Int = 1
    let b = 2

    var nome = "Ricardo"
    nome += " Lecheta"

    println("Olá \(nome), o resultado da soma é: \(a+b), qtde caracteres \(countElements(nome))")
}

func testeVarOpcional() {
    
    var nome:String?
    
    nome = "Ricardo Lecheta"

    // Não compila pois a variável está sendo utilizada sem inicializar
    if let s = nome {
        println("Olá \(s)")
    } else {
        println("Olá desconhecido")
    }
}

func testeConstrutor() {
    let c = Carro(nome:"Fusca",ano:1934)

    println("Carro: \(c.nome), ano: \(c.ano)")
}

func testeConstrutorConvenience() {
    let c = Carro(nome:"Fusca")
    
    println("Carro: \(c.nome), ano: \(c.ano)")
}

func testeConstrutor_FailableInitializers() {
    var c = Carro2(nome:"CarroQueNaoExiste",ano:1934)
    println("A: Carro \(c)")
    if(c != nil) {
        println("B: Carro: \(c!.nome), ano: \(c!.ano)")
    }
    
    c = Carro2(nome:"Fusca",ano:1934)
    println("C: Carro \(c)")
    if(c != nil) {
        println("D: Carro: \(c!.nome), ano: \(c!.ano)")
    }
}

func testeMetodoAcelerar() {
    let c = Carro(nome:"Fusca",ano:1934)
    
    c.acelerarComVelocidade(100);
    c.acelerarComVelocidade(100, distancia: 500)
}

func testeMetodoComRetorno() {
    let c = Carro(nome:"Fusca",ano:1934)
    
    let desc = c.getDescricao()
    println(desc)
}

// Protocolos
func testeProtocolo() {
    
    let c = Carro(nome:"Fusca",ano:1934)
    
    println("Carro: \(c.nome), ano: \(c.ano)")
    c.acelerarComVelocidade(110, distancia: 1000)
    
    // Abastecendo de álcool ou gasolina
    PostoDeGasolina.abastecerCarroComAlcool(c)
    PostoDeGasolina.abastecerCarroComGasolina(c)
}

func testeAnyObject() {
    let qualquer:AnyObject = Carro(nome:"Fusca",ano:1934)

    let c = qualquer as Carro
    
    println("Carro: \(c.nome), ano: \(c.ano)")
}

// Extensions
func testeExtensions() {
    
    let c = Carro(nome:"Fusca   ",ano:1934)
    
    println("Carro: [\(c.nome)]")
    println("Carro: [\(c.nome.trim())]")
}

// Array
func testeArray() {
    let c1 = Carro(nome:"Fusca",ano:1934)
    let c2 = Carro(nome:"Chevette",ano:1973)
    let c3 = Carro(nome:"Brasilia",ano:1934)
    
//    var carros:Array<Carro> = []
    //var carros = [c1,c2,c3]
    var carros = Array<Carro>()
    
    carros.append(c1)
    carros.append(c2)
    carros.append(c3)
    
    println("Este array possui \(carros.count) carros.")
    for c in carros {
        println(c.nome)
    }
}

// Dictionary
func testeDictionary() {
    let c1 = Carro(nome:"Fusca",ano:1934)
    let c2 = Carro(nome:"Chevette",ano:1973)
    let c3 = Carro(nome:"Brasilia",ano:1934)

//    var carros = ["c1":c1, "c2":c2, "c3":c3]
//    var carros:[String:Carro] = ["c1":c1, "c2":c2, "c3":c3]
    
    var carros = Dictionary<String,Carro>()
    carros["c1"] = c1
    carros["c2"] = c2
    carros["c3"] = c3
    
    for (chave,valor) in carros {
        println("Chave \(chave), Valor: \(valor.nome)")
    }
    
    // Recupera o Carro "c1" pela chave
    if let carro = carros["c1"] {
        println("Carro: \(carro.nome), ano: \(carro.ano)")
    }
    
}

// Comparar
func testeComparandoObjetos() {
    let c1 = Carro(nome:"Fusca",ano:1934)
    let c2 = Carro(nome:"Fusca",ano:1973)
    
    let b = c1 == c2
    println("Objetos iguais ? \(b) ")
}

// instanceof
func testeTipo() {

    var c:AnyObject
    
    c = Carro(nome:"Fusca",ano:1934)
    
    // Compara se é "c" é do tipo Carro
    var b = c is Carro
    println("Objeto carro é da classe Carro? : \(b)" )
}

//testeVar()
//testeVarOpcional()
testeConstrutor()
//testeConstrutorConvenience()
//testeConstrutor_FailableInitializers()
//testeMetodoAcelerar()
//testeMetodoComRetorno()
//testeProtocolo()
//testeAnyObject()
//testeExtensions()
//testeArray()
//testeDictionary()
//testeComparandoObjetos()
//testeTipo()

