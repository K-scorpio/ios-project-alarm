//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Kevin Hartley on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstnace.alarms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell ?? SwitchTableViewCell()
        let alarm = AlarmController.sharedInstnace.alarms[indexPath.row]

        // Configure the cell...
        cell.updateWithAlarm(alarm)

        return cell
    }
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(cell) else {return}
        let alarm = AlarmController.sharedInstnace.alarms[indexPath.row]
        AlarmController.sharedInstnace.toggleEnabled(alarm)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        if  alarm.enabled {
            scheduleLocalNotification(alarm)
            } else {
                cancelLocalNotification(alarm)
            }
            
        }




    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let alarm = AlarmController.sharedInstnace.alarms[indexPath.row]
            AlarmController.sharedInstnace.deleteAlarm(alarm)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            cancelLocalNotification(alarm)
        
        }    
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as? AlarmDetailTableViewController
        if segue.identifier == "toAlarmDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let alarm = AlarmController.sharedInstnace.alarms[indexPath.row]
            detailVC?.alarm = alarm
        }
    }
}






















