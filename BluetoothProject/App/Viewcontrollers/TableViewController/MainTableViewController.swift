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
        self.tableView.register(UINib(nibName: self.myCellName, bundle: nil), forCellReuseIdentifier: self.myCellName)
        self.centralManager = CBCentralManager(delegate: self, queue: self.myDispatchQueue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    
    // CORE BLUETOOTH
    
    private var centralManager : CBCentralManager?
    private var peripheralManager : CBPeripheralManager?
    private var myDispatchQueue : DispatchQueue = DispatchQueue(label: "solidusystems.BluetoothProject")
    
    //
    private let mySwitch : UISwitch = UISwitch(frame: .zero)

    private let myCellName : String = "MainTableViewCell"
    
    private var myDevices : [MyListBluetooth] = [
        MyListBluetooth(
            sectionName: "",
            footerName: "The bluetooth is on or off",
            itemsSection: [
                "Bluetooth",
            ]),
        MyListBluetooth(
            sectionName: "My Devices",
            footerName: "",
            itemsSection: [
                "AirPods Uno",
                "AirPods Dos",
                "AirPods Tres",
                "AirPods Cuatro",
                "AirPods Cinco",
            ]),
        MyListBluetooth(
            sectionName: "Other Devices",
            footerName : "Searching for nearby bluetooth devices to be able to connect.",
            itemsSection: [
                "AirPods Seis",
            ])]
    
    // MARK: - IBOutlet
    
    
    // MARK: - IBAction
    
    
    // MARK: - Public Func
    @objc func switchChnage(sender : UISwitch) {
        print(sender)
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
        }
        
        myCell.nameLable.text = self.myDevices[indexPath.section].itemsSection[indexPath.row]
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
        return section == 0 ? 30 : 45
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("CENTRAL MANAGER : didDiscover")
        
        if let peripheralName = peripheral.name {
            
            if !self.myDevices[2].itemsSection.contains(peripheralName){
                self.myDevices[2].itemsSection.append(peripheralName)
                
//                self.tableView.reloadData()
                
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
                }
            }
            
        }
        
        
        
              

    }
    
    
}

extension MainTableViewController : CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("peripheralManagerDidUpdateState")
    }
    
    
}

