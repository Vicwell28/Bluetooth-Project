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
        self.showLifecycle("viewDidLoad()", for: self.description)
        super.viewDidLoad()
        //        self.tableView.register(UINib(nibName: self.myCellName, bundle: nil), forCellReuseIdentifier: self.myCellName)
        self.tableView.estimatedRowHeight = 200.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.dataSouceDetails.append(detailsService(sectionName: "Device UUID", footerName: "", itemsSection: []))
        self.dataSouceDetails.append(detailsService(sectionName: "Advertiment Data", footerName: "", itemsSection: []))
        self.dataSouceDetails.append(detailsService(sectionName: "Services", footerName: "", itemsSection: []))
        
        self.dataSouceDetails[0].itemsSection.append(deviceUUID(UUID: self.peripheralManager!.identifier))
        self.dataSouceDetails[1].itemsSection.append(AdvertimentData(title: self.peripheralManager!.name!, des: "Device Local name"))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLifecycle("viewWillAppear()", for: self.description)
        
        self.centralManager?.delegate = self
        self.peripheralManager?.delegate = self
        
        print("RES ENVIADO : \(self.centralManager!)")
        print("RES ENVIADO : \(self.peripheralManager!)")
        
        
        self.peripheralManager?.discoverServices(nil)


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLifecycle("viewDidAppear()", for: self.description)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showLifecycle("viewWillDisappear()", for: self.description)
        
        self.dataSouceDetails[2].itemsSection.removeAll()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.showLifecycle("viewDidDisappear()", for: self.description)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueServicesPeripheral" {
            guard let segueServices = segue.destination as? ServicesPeripheralTableViewController else { return }
            
            segueServices.centralManager = self.centralManager
            segueServices.peripheralManager = self.peripheralManager
            segueServices.CBservice = (self.dataSouceDetails[(sender as! IndexPath).section].itemsSection[(sender as! IndexPath).row] as! servicesP).CBservice
            
            
        }
    }
    
    
    
    var dataSouceDetails : [detailsService] = []
    
    
    
    private let myCellName : String = "DetailsBluetoothTableViewCell"
    
    // MARK: - IBOutlet
    
    
    
    // MARK: - Public let / var
    
    
    
    // MARK: - Private let / var
    
    // CORE BLUETOOTH
    public var centralManager : CBCentralManager?
    public var peripheralManager : CBPeripheral?
    
    
    // MARK: - IBAction
    
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

// MARK: - MainTableViewController
extension DetailsPeripheralTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  self.dataSouceDetails.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSouceDetails[section].itemsSection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: self.myCellName, for: indexPath) as! DetailsBluetoothTableViewCell
        
        myCell.title.numberOfLines = 0
        
        
        if indexPath.section == 0 {
            myCell.title.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! deviceUUID).UUID.description
            
            
            myCell.selectionStyle = .none
            myCell.isUserInteractionEnabled = false
            
            
            //            myCell.title.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! deviceUUID).UUID.description
            //            myCell.desc.isHidden = true
            //            myCell.footer.isHidden = true
        } else if indexPath.section == 1 {
            
            myCell.title.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! AdvertimentData).title
            myCell.title.text! += (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! AdvertimentData).des
            
            myCell.selectionStyle = .none
            myCell.isUserInteractionEnabled = false
            
            
            
            //            myCell.title.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! AdvertimentData).title
            //            myCell.desc.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! AdvertimentData).des
            //            myCell.footer.isHidden = true
        } else {
            myCell.title.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! servicesP).custom
            myCell.title.text! += "\n\n \((self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! servicesP).isPrimary.description)"
            myCell.title.text! += "\n\n \((self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! servicesP).CBservice.description)"
            myCell.setSelected(false, animated: true)
            
            
            //            myCell.title.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! servicesP).custom
            //            myCell.desc.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! servicesP).isPrimary.description
            //            myCell.footer.text = (self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row] as! servicesP).CBservice.description
        }
        
        return myCell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSouceDetails[section].sectionName
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.dataSouceDetails[section].footerName
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 30 : 40
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("ESTE ES EL QUE SELECCIONO : \(self.dataSouceDetails[indexPath.section].itemsSection[indexPath.row])")
        
        performSegue(withIdentifier: "segueServicesPeripheral", sender: indexPath)
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
                
                self.dataSouceDetails[2].itemsSection.append(
                    servicesP(
                        custom: service.description,
                        CBservice: service,
                        isPrimary: service.isPrimary))
            }
            
            
            
            DispatchQueue.main.async {
                print(self.dataSouceDetails[2].itemsSection)
                
                self.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
                
            }
            
            //            if let fistService = services.first {
            //                peripheral.discoverCharacteristics(nil, for: fistService)
            //            }
            
            
            
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
        
        print(String(describing: service.characteristics))
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
