//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    var alarm: Alarm?
    
    //MARK: - Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var enableButton: UIButton!
    
    //MARK: - Actions
    
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {
            return
        }
        AlarmController.sharedInstnace.toggleEnabled(alarm)
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
        setupView()
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = titleTextField.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedInstnace.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            cancelLocalNotification(alarm)
            scheduleLocalNotification(alarm)
        } else {
            let alarm = AlarmController.sharedInstnace.addAlarm(timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleLocalNotification(alarm)
            }
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        setupView()
    }
    
    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        titleTextField.text = alarm.name
        self.title = alarm.name
    }

    // MARK: - Table view data source

    
    func setupView() {
        if alarm == nil {
            enableButton.hidden = true
        } else {
            enableButton.hidden = false
            if alarm?.enabled == true {
                enableButton.setTitle("Disable", forState: .Normal)
                enableButton.backgroundColor = UIColor.redColor()
                enableButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            } else {
                enableButton.setTitle("Enable", forState: .Normal)
                enableButton.backgroundColor = UIColor.grayColor()
                enableButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
