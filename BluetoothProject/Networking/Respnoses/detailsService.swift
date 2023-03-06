//
//  detailsService.swift
//  BluetoothProject
//
//  Created by soliduSystem on 13/02/23.
//

import Foundation
import CoreBluetooth

struct detailsService {
    var sectionName : String
    var footerName : String
    var itemsSection : [Any]
}

struct deviceUUID {
    let UUID : UUID
}

struct AdvertimentData {
    let title : String
    let des : String
}

struct servicesP {
    let custom : String
    let CBservice : CBService
    let isPrimary : Bool
}
