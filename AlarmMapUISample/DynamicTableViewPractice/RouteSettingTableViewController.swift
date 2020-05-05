//
//  RouteSettingTableViewController.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/01.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit



var repetitionDate = RepetitionDateStruct()

class RouteSettingTableViewController: UITableViewController {
    
    @IBOutlet var routeTitleCell: UITableViewCell!
    
    @IBOutlet var routeTitleTextField: UITextField!
    
    @IBOutlet var routeSubtitleTextField: UITextField!
    
    @IBOutlet var startingPointLabel: UILabel!
    
    @IBOutlet var destinationLabel: UILabel!
    
    @IBOutlet var arrivalTimeLabel: UILabel!
    
    @IBOutlet var arrivalTimeDatePicker: UIDatePicker!
    
    @IBOutlet var repetitionLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    
    var routeTitle = String()
    var routeSubtitle = String()
    var routeDestination = String()
    var routeArrivalTime = String()
    
    var defaultCellHeight:CGFloat = 0
    var isArrivalTimeDatePickerOpen = false
    var isDatePickerOpen = false
    
    let arrivalTimeDateFormatter = DateFormatter()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeTitleTextField.text = routeTitle
        routeSubtitleTextField.text = routeSubtitle
        
        startingPointLabel.text = ""
        destinationLabel.text = ""
        arrivalTimeLabel.text = ""
        repetitionLabel.text = ""
        dateLabel.text = ""
        
        defaultCellHeight = routeTitleCell.bounds.height
        
        arrivalTimeDateFormatter.locale = Locale(identifier: "ko")
        arrivalTimeDateFormatter.dateStyle = .none
        arrivalTimeDateFormatter.timeStyle = .short
        
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func arrivalTimeDatePickerValueChanged(_ sender: Any) {
        arrivalTimeLabel.text = arrivalTimeDateFormatter.string(from: arrivalTimeDatePicker.date)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repetitionLabel.text = repetitionDate.toString()
        if repetitionLabel.text == "" {
            repetitionLabel.text = "안 함"
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 2
        case 1:
            return 5
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1 && indexPath.row == 4){
            return 160//isArrivalTimeDatePickerOpen ? 160 : 0
        }
        else if (indexPath.section == 2 && indexPath.row == 2){
            return 160//isDatePickerOpen ? 160 : 0
        }
        else {
            return defaultCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1 && indexPath.row == 3){
            isArrivalTimeDatePickerOpen = !isArrivalTimeDatePickerOpen
            tableView.reloadRows(at: [IndexPath(row:indexPath.row+1, section:indexPath.section)], with: .fade)
        }
        else if (indexPath.section == 2 && indexPath.row == 1){
            isDatePickerOpen = !isDatePickerOpen
            tableView.reloadRows(at: [IndexPath(row: indexPath.row+1, section: indexPath.section)], with: .fade)
        }
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
