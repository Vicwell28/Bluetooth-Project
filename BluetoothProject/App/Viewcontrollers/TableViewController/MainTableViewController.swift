//
//  MainTableViewController.swift
//  BluetoothProject
//
//  Created by soliduSystem on 23/01/23.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: self.myCellName, bundle: nil), forCellReuseIdentifier: self.myCellName)
        
        //
        
        
    }
    //    @IBOutlet var tableView: UITableView!
    
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
    private let myCellName : String = "MainTableViewCell"
    
    // MARK: - IBOutlet
    
    
    // MARK: - IBAction
    
    
    // MARK: - Public Func
    
    
    // MARK: - Private Func
    
    
    struct mainStrucDevies : Codable {
        let sectionName : String
        let footerName : String
        let itemsSection : [String]
    }
    
    var myDevices : [mainStrucDevies] = [
        mainStrucDevies(
            sectionName: "",
            footerName: "The bluetooth is on or off",
            itemsSection: [
                "Bluetooth",
            ]),
        mainStrucDevies(
            sectionName: "My Devices",
            footerName: "",
            itemsSection: [
                "AirPods Uno",
                "AirPods Dos",
                "AirPods Tres",
                "AirPods Cuatro",
                "AirPods Cinco",
            ]),
        mainStrucDevies(
            sectionName: "Other Devices",
            footerName : "",
            itemsSection: [
                "AirPods SEIS",
                "AirPods SIETE",
                "AirPods OCHO",
                "AirPods NUEVE",
                "AirPods DIEZ",
                "AirPods ONCE",
                "AirPods SEIS",
                "AirPods SIETE",
                "AirPods OCHO",
                "AirPods NUEVE",
                "AirPods DIEZ",
                "AirPods ONCE",
            ])]
    
    
    
    
    
    let mySwitch : UISwitch = UISwitch(frame: .zero)
    
    
}


// MARK: - Services


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
    
    
    @objc func switchChnage(sender : UISwitch) {
        print(sender)
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
        return 30
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

