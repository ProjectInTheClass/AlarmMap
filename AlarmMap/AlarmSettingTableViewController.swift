//
//  AlarmSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class AlarmSettingTableViewController: UITableViewController {

    @IBOutlet var alarmTimeDatePicker: UIDatePicker!
    
    @IBOutlet var sunButton: UIButton!
    
    @IBOutlet var monButton: UIButton!
    
    @IBOutlet var tueButton: UIButton!
    
    @IBOutlet var wedButton: UIButton!
    
    @IBOutlet var thuButton: UIButton!
    
    @IBOutlet var friButton: UIButton!
    
    @IBOutlet var satButton: UIButton!
    
    @IBOutlet var aheadOfTimeSegmtdCtrll: UISegmentedControl!
    
    var dateButtonList = [UIButton]()
    
    var routeInfo:RouteInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        dateButtonList = [sunButton, monButton,tueButton,wedButton,thuButton,friButton,satButton]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        var senderDateButton = sender as! UIButton
        senderDateButton.isSelected = !(senderDateButton.isSelected)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        var aheadOf: AheadOfTime
        var repeatDates = [Bool]()
        switch aheadOfTimeSegmtdCtrll.selectedSegmentIndex {
        case 0:
            aheadOf = .none
        case 1:
            aheadOf = .five
        case 2:
            aheadOf = .fifteen
        case 3:
            aheadOf = .thirty
        default:
            aheadOf = .none
        }
        
        for index in 0...6{
            repeatDates.append(dateButtonList[index].isSelected)
        }
        
        let newRouteAlarm = RouteAlarm(time: alarmTimeDatePicker.date, repeatDates: repeatDates, aheadOf: aheadOf, route: routeInfo!.route, repeats: true)
        

        routeInfo!.routeAlarmList.append(newRouteAlarm)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
