//
//  RouteSettingTableViewController.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/01.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class RouteSettingTableViewController: UITableViewController {
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var routeTitleTextField: UITextField!
    
    @IBOutlet var routeSubtitleTextField: UITextField!
    
    @IBOutlet var startingPointLabel: UILabel!
    
    @IBOutlet var destinationLabel: UILabel!
    
    @IBOutlet var scheduledDateLabel: UILabel!
    
    @IBOutlet var scheduledDatePicker: UIDatePicker!
    
    var isNewRouteInfo = true //true: route addtion. false: setting route alreay exists
    
    var defaultCellHeight:CGFloat = 0.0

    let scheduledDateFormatter = DateFormatter()
    
    var tempRouteInfo: RouteInfo? = nil
    
    //section
    // by CSEDTD - TODO: category를 선택할 수 있게 해야 함
    var category:RouteCategoryEnum = .favorites
    var changedCategory:RouteCategoryEnum = .favorites
    //row
    var routeInfoNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        scheduledDateFormatter.locale = Locale(identifier: "ko")
        scheduledDateFormatter.dateStyle = .long
        scheduledDateFormatter.timeStyle = .short
        
        if(isNewRouteInfo){
            tempRouteInfo = RouteInfo() //new Route Info

            scheduledDateLabel.text = ""
            
            doneButton.isEnabled = false
        }
        
        else {
            tempRouteInfo = routeCategoryList[category.toInt()].routeInfoList[routeInfoNumber]
            
            routeTitleTextField.text = tempRouteInfo!.title
            routeSubtitleTextField.text = tempRouteInfo!.subtitle
            
            // by CSEDTD - toString method added
            startingPointLabel.text = tempRouteInfo!.route.startingPoint.toString()
            destinationLabel.text = tempRouteInfo!.route.destinationPoint.toString()
            
            scheduledDatePicker.date = tempRouteInfo!.scheduledDate
            scheduledDateLabel.text = scheduledDateFormatter.string(from: tempRouteInfo!.scheduledDate)
        }
    }

    
    @IBAction func doneButtonTapped(_ sender: Any) {
        tempRouteInfo!.title = routeTitleTextField.text!
        tempRouteInfo!.subtitle = routeSubtitleTextField.text!
        
        tempRouteInfo!.scheduledDate = scheduledDatePicker.date
        
        changedCategory = tempRouteInfo!.routeAlarmList.isEmpty ? .favorites : .routine
        
        if(isNewRouteInfo){
            //append to list
            routeCategoryList[changedCategory.toInt()].routeInfoList.append(tempRouteInfo!)
        }
        else if (category != changedCategory){
            routeCategoryList[changedCategory.toInt()].routeInfoList.append( routeCategoryList[category.toInt()].routeInfoList.remove(at: routeInfoNumber))
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "routeAlarmListSegue"){
            let routeAlarmListTableViewController = segue.destination as! RouteAlarmListTableViewController
            
            routeAlarmListTableViewController.routeInfo = tempRouteInfo
        }
        // by CSEDTD
        /*
        else if (segue.identifier == "routeSearchSegue") {
            let routeSearchViewController = segue.destination as! RouteSearchViewController
        }
         */
    }
    
    
    @IBAction func scheduledDatePickerValueChanged(_ sender: Any) {
        scheduledDateLabel.text = scheduledDateFormatter.string(from: scheduledDatePicker.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    //disable or enable save button
    @IBAction func routeTitleTextFieldChanged(_ sender: Any) {
        if(routeTitleTextField.text == ""){
            doneButton.isEnabled = false
        }
        else {
            doneButton.isEnabled = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 1
        case 3:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 2 && indexPath.row == 2){
            return 160
        }
        else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
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
