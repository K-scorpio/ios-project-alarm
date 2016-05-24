//
//  AlarmController.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

import UIKit

class AlarmController {
    
    static let sharedInstnace = AlarmController()
    
    var alarms = [Alarm]()
    
    private let kAlarms = "alarms"
    
    init() {
       loadFromPersistentStorage()
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.indexOf(alarm) else {return}
        alarms.removeAtIndex(index)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kAlarms)) as? [Alarm] else {return}
        self.alarms = alarms
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
}

protocol AlarmScheduler: class {
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        let localNotification = UILocalNotification()
        localNotification.alertTitle = "Alarm"
        localNotification.alertBody = "git back to wrk nw"
        localNotification.category = alarm.uuid
        localNotification.fireDate = NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    func cancelLocalNotification(alarm: Alarm) {
        guard let notification = UIApplication.sharedApplication().scheduledLocalNotifications else {
            return
        }
        let filteredNotification = notification.filter({$0.category == alarm.uuid})
        
        UIApplication.sharedApplication().cancelLocalNotification
    }
}






















