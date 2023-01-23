//
//  MyListBluetooth.swift
//  BluetoothProject
//
//  Created by soliduSystem on 23/01/23.
//

import Foundation

struct MyListBluetooth : Codable {
    var sectionName : String
    var footerName : String
    var itemsSection : [String]
}

struct MyListBluetoothWithPeripheral {
    var itemSectionName
    var idPeripheral
}

