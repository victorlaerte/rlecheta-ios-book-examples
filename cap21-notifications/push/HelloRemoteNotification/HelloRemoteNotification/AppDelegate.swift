//
//  AppDelegate.swift
//  HelloRemoteNotification
//
//  Created by Ricardo Lecheta on 7/6/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        let settings = UIUserNotificationSettings(forTypes: .Sound | .Alert | .Badge, categories: nil)

        // Solicitia permissão do usuário
        application.registerUserNotificationSettings(settings)

        println("registerForRemoteNotifications() ")
        
        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    
        println("register \(notificationSettings)")
        
        // Faz o registro para receber remote notifications
        application.registerForRemoteNotifications()
    }
    
    // Fez o registro para receber o Push.
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Aqui imprime o device token único deste dispositivo
        println("didRegisterForRemoteNotificationsWithDeviceToken \(deviceToken)")
    }

    // Falhou para registrar
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("didFailToRegisterForRemoteNotificationsWithError \(error)")
    }

    // Recebeu uma mensagem de Push
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
    {
        println("didReceiveRemoteNotification \(userInfo)")
        
        // userInfo é um NSDictionary
        var dict = userInfo as NSDictionary
        
        // Lê o json dentro de aps { }
        var notification:NSDictionary = dict.objectForKey("aps") as NSDictionary
        
        // Json da notificação
        println("notification \(notification)")
        
    }

}

