//
//  MyListBluetooth.swift
//  BluetoothProject
//
//  Created by soliduSystem on 23/01/23.
//

import Foundation
import CoreBluetooth

struct MyListBluetooth {
    var sectionName : String
    var footerName : String
    var itemsSection : [MyListBluetoothWithPeripheral]
}

struct MyListBluetoothWithPeripheral {
    var itemSectionName : String
    var idPeripheral : CBPeripheral?
}
