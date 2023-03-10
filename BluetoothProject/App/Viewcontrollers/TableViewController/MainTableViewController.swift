//
//  MainTableViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 23/01/23.
//

import UIKit
import CoreBluetooth

class MainTableViewController: UITableViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLifecycle("viewDidLoad()", for: self.description)
        self.tableView.register(UINib(nibName: self.myCellName, bundle: nil), forCellReuseIdentifier: self.myCellName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLifecycle("viewDidAppear()", for: self.description)
        
        self.centralManager = CBCentralManager(delegate: self, queue: self.myDispatchQueue)
        
        
        if self.peripheralManager != nil {
            print("PERIPERHIA;L NIL")
            self.centralManager?.cancelPeripheralConnection(self.peripheralManager!)
            self.centralManager?.scanForPeripherals(withServices: nil)
            self.peripheralManager = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLifecycle("viewWillAppear()", for: self.description)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showLifecycle("viewWillDisappear()", for: self.description)
        self.myDevices[2].itemsSection.removeAll()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.showLifecycle("viewDidDisappear()", for: self.description)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailsPeripheral"{
            let viewController = segue.destination as! DetailsPeripheralTableViewController
            
            viewController.centralManager = self.centralManager
            viewController.peripheralManager = self.peripheralManager
            
            print("CENTRAL ENVIADO : \(self.centralManager!)")
            print("PERIPHERAL ENVIADO : \(self.peripheralManager!)")
        }
    }
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    
    // CORE BLUETOOTH
    private var centralManager : CBCentralManager?
    private var peripheralManager : CBPeripheral?
    private var myDispatchQueue : DispatchQueue = DispatchQueue(label: "solidusystems.BluetoothProject")
    
    //
    
    
    private let mySwitch : UISwitch = UISwitch(frame: .zero)
    
    private let myCellName : String = "MainTableViewCell"
    
    private var myDevices : [MyListBluetooth] = [
        MyListBluetooth(
            sectionName: "",
            footerName: "The bluetooth is on or off",
            itemsSection: [
                MyListBluetoothWithPeripheral(
                    itemSectionName: "Bluetooth",
                    idPeripheral: nil
                )
            ]
        ),
        MyListBluetooth(
            sectionName: "My Devices",
            footerName: "",
            itemsSection: [
                MyListBluetoothWithPeripheral(
                    itemSectionName: "AirPods Uno",
                    idPeripheral: nil
                )
            ]
        ),
        MyListBluetooth(
            sectionName: "Others devices",
            footerName: "Looking for bluetooth devices to which it can connect.",
            itemsSection: []
        ),
        
    ]
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - IBAction
    
    
    // MARK: - Public Func
    @objc func switchChnage(sender : UISwitch) {
        print(sender)
        
        if self.peripheralManager != nil {
            
        }
    }
    
    // MARK: - Private Func
    
    
}

// MARK: - MainTableViewController
extension MainTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  self.myDevices.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myDevices[section].itemsSection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: self.myCellName, for: indexPath) as! MainTableViewCell
        
        if indexPath.section == 0 {
            mySwitch.addTarget(self, action: #selector(switchChnage), for: .valueChanged)
            myCell.accessoryView = mySwitch
            myCell.selectionStyle = .none
            myCell.isUserInteractionEnabled = false
            
        }
        
        myCell.nameLable.text = self.myDevices[indexPath.section].itemsSection[indexPath.row].itemSectionName
        return myCell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.myDevices[section].sectionName
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.myDevices[section].footerName
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 30 : 40
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("ESTE ES EL QUE SELECCIONO : \(self.myDevices[indexPath.section].itemsSection[indexPath.row])")
        
        
        DispatchQueue.main.async {
//            self.showViewControllerLoader()
            self.showLoaderTwo()
        }
        
        
        if let id = self.myDevices[indexPath.section].itemsSection[indexPath.row].idPeripheral {
            self.peripheralManager = id
            self.peripheralManager?.delegate = self
            self.centralManager?.stopScan()
            self.centralManager?.connect(self.peripheralManager!)
        }
    }
    
    
    
}


extension MainTableViewController : CBCentralManagerDelegate {
    
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
            DispatchQueue.main.async {
                self.mySwitch.isOn = true
            }
            
            self.centralManager?.scanForPeripherals(withServices: nil)
            
        @unknown default:
            print("FATAL ERROR")
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("CENTRAL MANAGER : didFailToConnect")
        
        DispatchQueue.main.async {
//            self.dismissViewControllerLoader()
            self.dissmisLoaderTwo()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("CENTRAL MANAGER : didConnect")
        
        DispatchQueue.main.async {
//            self.dismissViewControllerLoader()
            self.dissmisLoaderTwo()
            self.performSegue(withIdentifier: "segueDetailsPeripheral", sender: nil)
        }
        
        //        self.peripheralManager?.discoverServices([self.skimmerDeviceUUID])
        //        self.peripheralManager?.discoverServices(nil)
        
        
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
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("didDiscover")
        if let peripheralName = peripheral.name {
            
            print("PERIPERIAL : \(peripheralName) SERVICIOS \(String(describing: peripheral.services)) OTROS \(peripheral.state.rawValue)")
            
            if !self.myDevices[2].itemsSection.contains(where: {$0.itemSectionName ==  peripheralName}){
                self.myDevices[2].itemsSection.append(
                    MyListBluetoothWithPeripheral(
                        itemSectionName: peripheralName,
                        idPeripheral: peripheral)
                )
                
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
                }
            }
            
        }
    }
}

extension MainTableViewController : CBPeripheralDelegate {
    
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



