//
//  Alarm.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Alarm: Equatable {
    
    var fireTimeFromMidnight: NSTimeInterval
    var name: String
    var enabled: Bool
    var uuid: String
    
    var fireDate: NSDate? {

        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return nil
        }
        let fireTimeFromThisMorning = NSDate(timeInterval: fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        return fireTimeFromThisMorning
    }
    
    var fireTimeAsString: String {
        
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = (fireTimeFromMidnight/60)/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d: %2d PM", arguments: [hours - 12, minutes])
            } else if hours >= 12 {
                return String(format: "%2d:%02d PM", argumetns: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }


    init(fireTimeFromMidnight: NSTimeInterval, name: String, enabled: Bool = true, uuid: String = NSUUID().UUIDString) {
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return (lhs.fireTimeFromMidnight == rhs.fireTimeFromMidnight && lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid)
}
