//
//  DetailsPeripheralTableViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 30/01/23.
//

import UIKit
import CoreBluetooth

class DetailsPeripheralTableViewController: UITableViewController {

    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centralManager?.delegate = self
        self.peripheralManager?.delegate = self
        
        print("RES ENVIADO : \(self.centralManager!)")
        print("RES ENVIADO : \(self.peripheralManager!)")
        
        self.peripheralManager?.discoverServices(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - IBOutlet
    
    
    
    // MARK: - Public let / var
    
    
    
    // MARK: - Private let / var
    
    // CORE BLUETOOTH
    public var centralManager : CBCentralManager?
    public var peripheralManager : CBPeripheral?
    
    
    // MARK: - IBAction

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


}
// MARK: - Public Func
extension DetailsPeripheralTableViewController {
    
}
// MARK: - Private Func
extension DetailsPeripheralTableViewController {
    
}
// MARK: - Services
extension DetailsPeripheralTableViewController {
    
}

extension DetailsPeripheralTableViewController : CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("CENTRAL MANAGER : centralManagerDidUpdateState")
        
        switch central.state {
        case .poweredOff :
            print("POWERD OFF")
        case .resetting:
            print("RESETTING")
        case .unauthorized:
            print("UNAUTHORIZED")
        case .unknown:
            print("UNKNOWN")
        case .unsupported:
            print("UNSUPPORTED")
        case .poweredOn:
            print("POWERED ON")
           
        @unknown default:
            print("FATAL ERROR")
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("CENTRAL MANAGER : didFailToConnect")
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("CENTRAL MANAGER : didConnect")
        
        
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("CENTRAL MANAGER : willRestoreState")
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("CENTRAL MANAGER : didDisconnectPeripheral")
        
    }
    
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        print("CENTRAL MANAGER : didUpdateANCSAuthorizationFor")
        
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        print("CENTRAL MANAGER : connectionEventDidOccur")
        
    }
}


// MARK: - Other
extension DetailsPeripheralTableViewController : CBPeripheralDelegate {
    
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
