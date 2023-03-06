//
//  servicePeriperal.swift
//  BluetoothProject
//
//  Created by soliduSystem on 13/02/23.
//

import Foundation

struct servicePeriperal {
    var sectionName : String
    var footerName : String
    var itemsSection : [Any]
}

struct StructNotifyValue {
    let value : String
}

struct StructWriteValue {
    let value : String
}

struct StructReadValue {
    let value : String
}

struct StructDescriptor {
    let value : String
}


//OTHER

struct customService {
    let name : String
    let uuid : String
}

struct cutomsSeriveProperties {
    let value : String
}
