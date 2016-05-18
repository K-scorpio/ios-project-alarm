//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - IBActions
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate?.switchCellSwitchValueChanged(self)
    }
    
        // Configure the view for the selected state
        
        func updateWithAlarm(alarm: Alarm) {
            nameLabel.text = alarm.name
            timeLabel.text = alarm.fireTimeAsString
            switchButton.on = alarm.enabled
        }
}

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}
