//
//  DetailsBluetoothTableViewCell.swift
//  BluetoothProject
//
//  Created by soliduSystem on 02/02/23.
//

import UIKit

class DetailsBluetoothTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        print("prepare for reuse ; \(self)")
        
        self.accessoryView = nil
        self.title.text = ""
    }
    
    //    @IBOutlet weak var footer: UILabel!
    //    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var title: UILabel!
}
