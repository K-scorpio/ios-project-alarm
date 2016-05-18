//
//  AlarmController.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []

    init() {
        self.alarms = []
        self.alarms = mockAlarms()
    }
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        deleteAlarm(alarm)
        addAlarm(fireTimeFromMidnight, name: name)
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let indexOfAlarm = alarms.indexOf(alarm) else {
            return
        }
        alarms.removeAtIndex(indexOfAlarm)
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    func mockAlarms() -> [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 30421, name: "Wake Up", enabled: true)
        return [alarm1]
    }
  
}