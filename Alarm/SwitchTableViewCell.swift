//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - IBActions
    
    @IBAction func switchValueChanged(sender: AnyObject) {
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
