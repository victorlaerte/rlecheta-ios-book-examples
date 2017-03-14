//
//  Alerta.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/12/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class Alerta {
    
    class func alerta(msg : String, viewController: UIViewController) {
        
        Alerta.alerta(msg, viewController: viewController, action: nil)
    }

    class func alerta(msg : String, viewController: UIViewController,action: ((UIAlertAction!) -> Void)!) {
        
        var alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: action))
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}