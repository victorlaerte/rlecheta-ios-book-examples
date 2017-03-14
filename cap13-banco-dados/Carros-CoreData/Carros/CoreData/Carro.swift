//
//  Carro.swift
//  Carros-CoreData
//
//  Created by Ricardo Lecheta on 7/25/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation
import CoreData

@objc(Carro)
class Carro: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var latitude: String
    @NSManaged var longitude: String
    @NSManaged var nome: String
    @NSManaged var timestamp: NSDate
    @NSManaged var tipo: String
    @NSManaged var url_foto: String
    @NSManaged var url_info: String
    @NSManaged var url_video: String

}
