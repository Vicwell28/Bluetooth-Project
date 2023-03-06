//
//  ServicesPeripheralTableViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 30/01/23.
//

import UIKit
import CoreBluetooth

class ServicesPeripheralTableViewController: UITableViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLifecycle("viewDidLoad()", for: self.description)
        
        self.datasource = []
        
        self.datasource.append(
            servicePeriperal(
                sectionName: "Custom Service",
                footerName: "",
                itemsSection: []))
        
        self.datasource.append(
            servicePeriperal(
                sectionName: "Properties",
                footerName: "",
                itemsSection: []))
        
        self.datasource[0].itemsSection.append(customService(name: "Service", uuid: CBservice.uuid.uuidString))
        
        
        self.datasource[1].itemsSection.append(cutomsSeriveProperties(value: "Write, Read, Notify, Indicate"))
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLifecycle("viewWillAppear()", for: self.description)
        
        self.centralManager.delegate = self
        self.peripheralManager.delegate = self
        self.peripheralManager.discoverCharacteristics(nil, for: CBservice)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLifecycle("viewDidAppear()", for: self.description)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showLifecycle("viewWillDisappear()", for: self.description)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.showLifecycle("viewDidDisappear()", for: self.description)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCharacteristicPeripheral" {
            guard let segueServices = segue.destination as? CharacteristicPeripheralTableViewController else { return }
            
            print("ENTRO EN EL PREPARE")
            
            print("CENTRAL : \(self.centralManager!)")
            print("peripheralManager : \(self.peripheralManager!)")
            print("CBservice : \(self.CBservice!)")
            print("CBcharacteristic : \(self.CBcharacteristic!)")
            
            
            segueServices.centralManager = self.centralManager
            segueServices.peripheralManager = self.peripheralManager
            segueServices.CBservice = self.CBservice
            segueServices.CBcharacteristic = self.CBcharacteristic!
        }
    }
    
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - Public let / var
    
    // CORE BLUETOOTH
    public var centralManager : CBCentralManager!
    public var peripheralManager : CBPeripheral!
    public var CBservice : CBService!
    public var CBcharacteristic : CBCharacteristic?
    
    // MARK: - Private let / var
    var datasource : [servicePeriperal]!
    
    
    // MARK: - IBAction
    
    
    
}
// MARK: - Public Func
extension ServicesPeripheralTableViewController {
    
}
// MARK: - Private Func
extension ServicesPeripheralTableViewController {
    
}

// MARK: - MainTableViewController
extension ServicesPeripheralTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.datasource.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource[section].itemsSection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! DetailsBluetoothTableViewCell
        
        
        if indexPath.section == 0 {
            myCell.title.text = (self.datasource[indexPath.section].itemsSection[indexPath.row] as! customService).uuid
            myCell.selectionStyle = .none
            myCell.isUserInteractionEnabled = false
        } else {
            myCell.title.text = (self.datasource[indexPath.section].itemsSection[indexPath.row] as! cutomsSeriveProperties).value
            
            let imageview = UIImageView(frame: .zero)
            
            imageview.image = UIImage(systemName: "chevron.right")
            
            myCell.title.textColor = .blue
            
            myCell.accessoryView = imageview
            
        }
        
        return myCell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.datasource[section].sectionName
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.datasource[section].footerName
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 30 : 40
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("ESTE ES EL QUE SELECCIONO : \(self.datasource[indexPath.section].itemsSection[indexPath.row])")
        
        performSegue(withIdentifier: "segueCharacteristicPeripheral", sender: indexPath)
    }
    
    
}
// MARK: - Services
extension ServicesPeripheralTableViewController : CBCentralManagerDelegate {
    
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
        
        DispatchQueue.main.async {
            let myViewController = self.navigationController?.viewControllers.first(where: {$0 is MainTableViewController})
            self.navigationController?.popToViewController(myViewController!, animated: true)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        print("CENTRAL MANAGER : didUpdateANCSAuthorizationFor")
        
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        print("CENTRAL MANAGER : connectionEventDidOccur")
        
    }
}

// MARK: - Other
extension ServicesPeripheralTableViewController : CBPeripheralDelegate {
    
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
        
        
        guard let valueCharacterist = characteristic.value else { return }
        
        if let valueString = String(data: valueCharacterist, encoding: .utf8) {
            print("ESTE ES EL VALUR REAL DEL PERIFIPERIAL : \(valueString)")
        }
            
        
        print("\n\n")
        
        print("characteristic \(characteristic) \n\n")
        print("characteristic \(String(describing: characteristic.value?.description)) \n\n")
        print("characteristic \(String(describing: String(data: characteristic.value!, encoding: .ascii))) \n\n")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print("CBPeripheral : didUpdateValueFor")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didDiscoverDescriptorsFor")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("CBPeripheral : didDiscoverCharacteristicsFor ESTE")
        
        print(String(describing: service.characteristics))
        
        
        if let fistCharacteristic : CBCharacteristic = service.characteristics?.first {
            
            if fistCharacteristic.properties.contains(.read) {
                print("\(fistCharacteristic.uuid) .read")
                peripheral.readValue(for: fistCharacteristic)
            }
            
            if fistCharacteristic.properties.contains(.notify) {
                print("\(fistCharacteristic.uuid) .notify")
            }
            
            if fistCharacteristic.properties.contains(.write) {
                print("\(fistCharacteristic.uuid) .write")
            }
            
            if fistCharacteristic.properties.contains(.indicate) {
                print("\(fistCharacteristic.uuid) .indicate")
            }
            
            if fistCharacteristic.properties.contains(.broadcast) {
                print("\(fistCharacteristic.uuid) .broadcast")
            }
            
            print("\n\n")
            print("description : \(fistCharacteristic.description) \n\n")
            print("isNotifying : \(fistCharacteristic.isNotifying) \n\n")
            print("uuid : \(fistCharacteristic.uuid) \n\n")
            print("service : \(String(describing: fistCharacteristic.service)) \n\n")
            print("properties : \(fistCharacteristic.properties.rawValue) \n\n")
            print("value : \(String(describing: fistCharacteristic.value)) \n\n")
            
            self.CBcharacteristic = fistCharacteristic
            
            print("ESTA ES : \(self.CBcharacteristic!)")
            
            peripheral.readValue(for: fistCharacteristic)
            
            
            
            peripheral.setNotifyValue(true, for: fistCharacteristic)
            
            print("\n\n")
            print("description : \(fistCharacteristic.description) \n\n")
            print("isNotifying : \(fistCharacteristic.isNotifying) \n\n")
            print("uuid : \(fistCharacteristic.uuid) \n\n")
            print("service : \(String(describing: fistCharacteristic.service)) \n\n")
            print("properties : \(fistCharacteristic.properties.rawValue) \n\n")
            print("value : \(String(describing: fistCharacteristic.value)) \n\n")
            
            
        }
        
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        print("CBPeripheral : toSendWriteWithoutResponse")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("\n\n")
        print("\n\n")
        
        print("CBPeripheral : didUpdateNotificationStateFor")
        
        print("error : \(String(describing: error))\n\n")
        print("value : \(String(describing: characteristic.value))\n\n")
        
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        print("CBPeripheral : didDiscoverIncludedServicesFor")
        
    }
}



