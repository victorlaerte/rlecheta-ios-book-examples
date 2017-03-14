//
//  Prefs.swift
//  Carros
//
//  Created by Ricardo Lecheta on 6/30/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class Prefs {
    
    class func setString(valor: String, chave: String) {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(valor, forKey: chave)
        prefs.synchronize()
    }
    
    class func getString(chave: String) -> String! {
        let prefs = NSUserDefaults.standardUserDefaults()
        var s = prefs.stringForKey(chave)
        return s
    }
    
    class func setInt(valor: Int, chave: String) {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(valor, forKey: chave)
        prefs.synchronize()
    }

    class func getInt(chave: String) -> Int! {
        let prefs = NSUserDefaults.standardUserDefaults()
        var s = prefs.integerForKey(chave)
        return s
    }
}