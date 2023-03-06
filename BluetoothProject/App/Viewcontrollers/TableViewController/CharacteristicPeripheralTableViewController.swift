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
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLifecycle("viewDidLoad()", for: self.description)
        
        
        self.centralManager.delegate = self
        self.peripheralManager.delegate = self
        
        self.dataSource.append(
            servicePeriperal(
                sectionName: "Notify Value",
                footerName: "",
                itemsSection: []))
        
        self.dataSource.append(
            servicePeriperal(
                sectionName: "Write value",
                footerName: "",
                itemsSection: []))
        
        self.dataSource.append(
            servicePeriperal(
                sectionName: "Read Value",
                footerName: "",
                itemsSection: []))
        
        self.dataSource.append(
            servicePeriperal(
                sectionName: "Descriptor",
                footerName: "",
                itemsSection: []))
        
        self.dataSource[0].itemsSection.append(StructNotifyValue(value: "Notify"))
        
        self.dataSource[1].itemsSection.append(StructWriteValue(value: "Write Value"))
        
        self.dataSource[2].itemsSection.append(StructReadValue(value: "Read Value"))
        
        self.dataSource[3].itemsSection.append(StructDescriptor(value: "Descriptor"))
        
        print(self.dataSource.count)
        
        
        print("CENTRAL : \(self.centralManager!)")
        print("peripheralManager : \(self.peripheralManager!)")
        print("CBservice : \(self.CBservice!)")
        print("CBcharacteristic : \(self.CBcharacteristic!)")
        
        self.peripheralManager.setNotifyValue(true, for: self.CBcharacteristic)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLifecycle("viewWillAppear()", for: self.description)
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
    
    @objc func switchChnage(sender : UISwitch) {
//        print(sender)
        
        if sender.isOn {
            print("IS ONE")
            self.peripheralManager.setNotifyValue(true, for: self.CBcharacteristic)
        } else {
            print("IS OFF")
            self.peripheralManager.setNotifyValue(false, for: self.CBcharacteristic)
        }
        
    }
    
    // MARK: - IBOutlet
    
    
    // MARK: - Public let / var
    // CORE BLUETOOTH
    public var centralManager : CBCentralManager!
    public var peripheralManager : CBPeripheral!
    public var CBservice : CBService!
    public var CBcharacteristic : CBCharacteristic!
    
    private let mySwitch : UISwitch = UISwitch(frame: .zero)
    
    private var dataSource : [servicePeriperal] = []
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(self.dataSource.count)
        return self.dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].itemsSection.count
    }
    

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! DetailsBluetoothTableViewCell
        
        print("INDEXPATH : \(indexPath)")
        
        myCell.selectionStyle = .blue
        myCell.isUserInteractionEnabled = true
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                //            mySwitch.addTarget(self, action: #selector(switchChnage), for: .valueChanged)
                mySwitch.addTarget(self, action: #selector(switchChnage), for: .valueChanged)
                mySwitch.isEnabled = true
                mySwitch.isOn = true
                myCell.accessoryView = mySwitch
            }
            myCell.selectionStyle = .none
//            myCell.isUserInteractionEnabled = false
            myCell.title.text = (self.dataSource[indexPath.section].itemsSection[indexPath.row] as! StructNotifyValue).value
        } else if indexPath.section == 1 {
            myCell.title.text = (self.dataSource[indexPath.section].itemsSection[indexPath.row] as! StructWriteValue).value
            myCell.tag = 1
            
            if !(indexPath.row == 0) {
                myCell.selectionStyle = .none
                myCell.isUserInteractionEnabled = false
            }
            
        } else if indexPath.section == 2 {
            myCell.title.text = (self.dataSource[indexPath.section].itemsSection[indexPath.row] as! StructReadValue).value
            myCell.tag = 2
            
            if !(indexPath.row == 0) {
                myCell.selectionStyle = .none
                myCell.isUserInteractionEnabled = false
            }
            
        } else {
            myCell.title.text = (self.dataSource[indexPath.section].itemsSection[indexPath.row] as! StructDescriptor).value
            myCell.selectionStyle = .none
            myCell.isUserInteractionEnabled = false
        }
        
        
        
        return myCell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSource[section].sectionName
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.dataSource[section].footerName
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 30 : 40
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let tag = tableView.cellForRow(at: indexPath)?.tag else {
            return
        }
        
        if tag == 1 {
            
            let alerta = UIAlertController(title: "Write Value", message: nil, preferredStyle: .alert)
            
            alerta.addTextField{ textField in
                textField.placeholder = "Hi"
            }
            
            alerta.addAction(UIAlertAction(title: "Write ", style: .default, handler: { UIAlertAction in
                print(alerta.textFields![0].text!)
                
                if let data = alerta.textFields![0].text!.data(using: .ascii) {
                    print("Se mando a escribri \(data)")
                    self.peripheralManager.writeValue(data, for: self.CBcharacteristic, type: .withResponse)
                    
                    
                    
                }
                
            }))
            
            alerta.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(alerta, animated: true)
            
        } else if tag == 2 {
            peripheralManager.readValue(for: self.CBcharacteristic)
        }
        
    }
    
    
}

extension CharacteristicPeripheralTableViewController : CBPeripheralDelegate {
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        print("CBPeripheral : peripheralDidUpdateName")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didWriteValueFor 1")
        
        
        if let error = error {
            print("ERROR \(error.localizedDescription)")
            return
        }
        
        
        peripheral.readValue(for: characteristic)
        
        
        return

        
        
//        DispatchQueue.main.async {
//
//            if let value = characteristic.value {
//
//                let valuedos = [UInt8](value)
//
//                print(valuedos)
//
//
//                if let newvalue = valuedos.first {
//                    print(newvalue)
//
//
//                    print(String(cString: valuedos))
//
//
//                }
//
//
//
//
//                print(" ESTE ES EL RESUTLADO DOS : \(String(describing: String(data: value, encoding: .utf8)))")
//                print(" ESTE ES EL RESUTLADO DOS : \(String(describing: String(data: value, encoding: .ascii.self)))")
//
//
//
//                if self.dataSource[1].itemsSection.count > 5 {
//                    self.dataSource[1].itemsSection.removeLast()
//                }
//
//                self.dataSource[1].itemsSection.append(StructWriteValue(value: "\(String(describing: String(data: value, encoding: .ascii.self)))"))
//
//                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
//            }
//        }
        
        
        
        //ESCRIBRIR
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("CBPeripheral : didWriteValueFor 2")
        
        
        
        
        
        
        
        
        //LEYENDO
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        print("CBPeripheral : didOpen")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("CBPeripheral : didModifyServices")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("CBPeripheral : didDiscoverServices")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("CBPeripheral : didReadRSSI")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didUpdateValueFor characteristic ENTRA EN ESTE")
        
        guard let valueDos = characteristic.value else { return }
        
        print("characteristic.value : \(valueDos)")
        
        if let valueDosDos = String(data: valueDos, encoding: .ascii) {
            print("MAS RESTULTADOS : \(valueDosDos) : NADA")
            print("//////////////////")
            
            DispatchQueue.main.async {
                
                if self.dataSource[2].itemsSection.count > 4 {
                    self.dataSource[2].itemsSection.removeLast()
                }
                
                self.dataSource[2].itemsSection.insert(StructReadValue(value: "\(valueDosDos)"), at: 1)
                
                self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            }
            
        } else {
            print("MAS RESULTADOS FALLO")
        }
        
        if var data = characteristic.value {
            
            let byteArray = [UInt8](data)
            
            
           
            print([UInt8](data))

            print(byteArray[0])

            
            
//            data.removeLast()
            print(" ESTE ES EL RESUTLADO : \(String(describing: String(data: data, encoding: .utf8)))")
            print(" ESTE ES EL RESUTLADO : \(String(describing: String(data: data, encoding: .ascii.self)))")
            
        }
        
        
        
//        DispatchQueue.main.async {
//
//            if self.dataSource[2].itemsSection.count > 4 {
//                self.dataSource[2].itemsSection.removeLast()
//            }
//            //            self.dataSource[2].itemsSection.append(StructReadValue(value: characteristic.description))
//            if let value = characteristic.value {
//                self.dataSource[2].itemsSection.insert(StructReadValue(value: "\(String(describing: String(data: value, encoding: .ascii.self)))"), at: 1)
//
//                self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
//            }
            
            
//        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print("CBPeripheral : didUpdateValueFor descriptor")
        
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print("CBPeripheral : didDiscoverDescriptorsFor")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("CBPeripheral : didDiscoverCharacteristicsFor ESTE")
        
        guard let CBcharacteristic = service.characteristics else { return }
        
        for characteristic in CBcharacteristic {
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
        }
        
        
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




// MARK: - Services
extension CharacteristicPeripheralTableViewController : CBCentralManagerDelegate {
    
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
        
        
        self.dismiss(animated: true) {
        }
        
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
