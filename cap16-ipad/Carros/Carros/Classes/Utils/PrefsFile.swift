//
//  PrefsFile.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/1/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class PrefsFile : Prefs {
    
    class func getFilePath(nome: String) -> String {
        // Caminho com o arquivo
        let path = NSHomeDirectory() + "/Documents/" + nome + ".txt"
        println(path)
        return path
    }

    override class func setString(valor: String, chave: String) {
        // Caminho com o arquivo
        let path = PrefsFile.getFilePath(chave)
        let nsdata = StringUtils.toNSData(valor)
        var s = StringUtils.toString(nsdata)
        // Escreve o NSData para arquivo
        nsdata.writeToFile(path, atomically: true)
    }

    override class func getString(chave: String) -> String! {
        // Caminho com o arquivo
        let path = PrefsFile.getFilePath(chave)
        let nsdata = NSData(contentsOfFile: path)
        let valor = StringUtils.toString(nsdata)
        return valor
    }
    
    override class func setInt(valor: Int, chave: String) {
        // Converte Int para String e delega para o outro método
        setString(String(valor), chave: chave)
    }
    
    override class func getInt(chave: String) -> Int {
        let valorString: String! = getString(chave)
        if(valorString == nil) {
            // Não existe
            return 0
        }
        let valorInt = valorString.toInt()
        // A sintaxe ! desempacota o tipo optional Int!
        return valorInt!
    }
}
