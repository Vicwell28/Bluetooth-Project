//
//  CharacteristicPeripheralTableViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 30/01/23.
//

import UIKit
import CoreBluetooth

class CharacteristicPeripheralTableViewController: UITableViewController {

    // MARK: - Override Func
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - Public let / var
    
    // CORE BLUETOOTH
    private var centralManager : CBCentralManager?
    private var peripheralManager : CBPeripheral?
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}

// MARK: - Public Func
extension CharacteristicPeripheralTableViewController {
    
}
// MARK: - Private Func
extension CharacteristicPeripheralTableViewController {
    
}
// MARK: - Services
extension CharacteristicPeripheralTableViewController {
    
}
// MARK: - Other
extension CharacteristicPeripheralTableViewController {
    
}

extension CharacteristicPeripheralTableViewController : CBPeripheralDelegate {
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        print("CBPeripheral : peripheralDidUpdateName")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didWriteValueFor")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("CBPeripheral : didWriteValueFor")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        print("CBPeripheral : didOpen")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("CBPeripheral : didModifyServices")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("CBPeripheral : didDiscoverServices")

        if let services = peripheral.services {
            print("ENCONTOR SERVICOS")
            
            print(services)
            
            for service in services {
                print("SERVICES : \(service)")
            }
            
            
        } else {
            print("NO ENCONTRO SERVICES")
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("CBPeripheral : didReadRSSI")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didUpdateValueFor")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print("CBPeripheral : didUpdateValueFor")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didDiscoverDescriptorsFor")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("CBPeripheral : didDiscoverCharacteristicsFor")

    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        print("CBPeripheral : toSendWriteWithoutResponse")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didUpdateNotificationStateFor")

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        print("CBPeripheral : didDiscoverIncludedServicesFor")

    }
    
    
    
}



