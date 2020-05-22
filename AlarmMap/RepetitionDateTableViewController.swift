//
//  RepetitionDateTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/20.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RepetitionDateTableViewController: UITableViewController {
    
    var routeInfo:RouteInfo? = nil
    var tempRepetitionDate = RepetitionDate()
    
    //Labels
    @IBOutlet var monRepetitionTimeLabel: UILabel!
    
    @IBOutlet var tueRepetitionTimeLabel: UILabel!
    
    @IBOutlet var wedRepetitionTimeLabel: UILabel!
    
    @IBOutlet var thuRepetitionTimeLabel: UILabel!
    
    @IBOutlet var friRepetitionTimeLabel: UILabel!
    
    @IBOutlet var satRepetitionTimeLabel: UILabel!
    
    @IBOutlet var sunRepetitionTimeLabel: UILabel!
    
    //switches
    @IBOutlet var monRepetitionSwitch: UISwitch!
    
    @IBOutlet var tueRepetitionSwitch: UISwitch!
    
    @IBOutlet var wedRepetitionSwitch: UISwitch!
    
    @IBOutlet var thuRepetitionSwitch: UISwitch!
    
    @IBOutlet var friRepetitionSwitch: UISwitch!
    
    @IBOutlet var satRepetitionSwitch: UISwitch!
    
    @IBOutlet var sunRepetitionSwitch: UISwitch!
    
    //DatePickers
    @IBOutlet var monRepetitionTimeDatePicker: UIDatePicker!
    
    @IBOutlet var tueRepetitionTimeDatePicker: UIDatePicker!
    
    @IBOutlet var wedRepetitionTimeDatePicker: UIDatePicker!
    
    @IBOutlet var thuRepetitionTimeDatePicker: UIDatePicker!
    
    @IBOutlet var friRepetitionTimeDatePicker: UIDatePicker!
    
    @IBOutlet var satRepetitionTimeDatePicker: UIDatePicker!
    
    @IBOutlet var sunRepetitionTimeDatePicker: UIDatePicker!
    
    //list
    var repetitionTimeLabelList =
        [DateEnum:UILabel]()
    
    var repetitionSwitchList =
        [DateEnum:UISwitch]()
    
    var repetitionTimeDatePickerList = [DateEnum:UIDatePicker]()
    
    //dateFormatter
    var repetitionTimeDateFormatter =
        DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempRepetitionDate = routeInfo!.repetitionDate.clone()
        
        repetitionTimeLabelList =
            [.mon:monRepetitionTimeLabel,.tue:tueRepetitionTimeLabel,.wed:wedRepetitionTimeLabel,.thu:thuRepetitionTimeLabel,.fri:friRepetitionTimeLabel,.sat:satRepetitionTimeLabel,.sun:sunRepetitionTimeLabel]
        
        repetitionSwitchList =
            [.mon:monRepetitionSwitch, .tue:tueRepetitionSwitch,.wed:wedRepetitionSwitch,.thu:thuRepetitionSwitch,.fri:friRepetitionSwitch,.sat:satRepetitionSwitch,.sun:sunRepetitionSwitch]
        
        repetitionTimeDatePickerList =
            [.mon:monRepetitionTimeDatePicker, .tue:tueRepetitionTimeDatePicker, .wed:wedRepetitionTimeDatePicker,.thu:thuRepetitionTimeDatePicker,.fri:friRepetitionTimeDatePicker,.sat:satRepetitionTimeDatePicker,.sun:sunRepetitionTimeDatePicker]
        
        repetitionTimeDateFormatter.locale = Locale(identifier: "ko")
        repetitionTimeDateFormatter.dateStyle = .none
        repetitionTimeDateFormatter.timeStyle = .short
        
        for (date,flag) in routeInfo!.repetitionDate.repetitionDateFlags{
            
            if (flag){
                repetitionTimeDatePickerList[date]!.date =
                    routeInfo!.repetitionDate.repetitionTimeOf(date: date)!
                repetitionTimeLabelList[date]!.text = repetitionTimeDateFormatter.string(from: routeInfo!.repetitionDate.repetitionTimeOf(date: date)!)
            }
            else{
                repetitionTimeLabelList[date]!.text = ""
            }
            
            repetitionSwitchList[date]!.isOn = flag
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        routeInfo!.repetitionDate = tempRepetitionDate
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func updateRepetitionTimeOf(date:DateEnum){
        repetitionTimeLabelList[date]!.text = repetitionTimeDateFormatter.string(from: repetitionTimeDatePickerList[date]!.date)
        tempRepetitionDate.repetitionTimeOfDate[date] = repetitionTimeDatePickerList[date]!.date
    }
    
    @IBAction func monRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .mon)
    }
    
    
    @IBAction func tueRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .tue)
    }
    
    @IBAction func wedRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .wed)
    }
    
    @IBAction func thuRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .thu)
    }
    
    @IBAction func friRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .fri)
    }
    
    @IBAction func satRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .sat)
    }
    
    @IBAction func sunRepetitionTimeDatePickerValueChanged(_ sender: Any) {
        updateRepetitionTimeOf(date: .sun)
    }
    
    func updateDatePickerAndLabelAndRepetitionDateOf(date: DateEnum){
        if(repetitionSwitchList[date]!.isOn){
            repetitionTimeDatePickerList[date]!.date = routeInfo!.repetitionDate.repetitionTimeOf(date: date)!
            repetitionTimeLabelList[date]!.text = repetitionTimeDateFormatter.string(from: repetitionTimeDatePickerList[date]!.date)
        }
        else{
            repetitionTimeLabelList[date]!.text = ""
        }
        tempRepetitionDate.repetitionDateFlags[date] = repetitionSwitchList[date]!.isOn
     }
    
    @IBAction func monRepetitionSwitchTapped(_ sender: Any) {
        updateDatePickerAndLabelAndRepetitionDateOf(date: .mon)
    }
    
    @IBAction func tueRepetitionSwitchTapped(_ sender: Any) {
        updateDatePickerAndLabelAndRepetitionDateOf(date: .tue)
    }
    
    @IBAction func wedRepetitionSwitchTapped(_ sender: Any) {
        updateDatePickerAndLabelAndRepetitionDateOf(date: .wed)
    }
    
    @IBAction func thuRepetitionSwitchTapped(_ sender: Any) {
        updateDatePickerAndLabelAndRepetitionDateOf(date: .thu)
    }
    
    @IBAction func friRepetitionSwitchTapped(_ sender: Any) {
        updateDatePickerAndLabelAndRepetitionDateOf(date: .fri)
        
    }
    
    @IBAction func satRepetitionSwitchTapped(_ sender: Any) {
       updateDatePickerAndLabelAndRepetitionDateOf(date: .sat)
    }
    
    @IBAction func sunRepetitionSwitchTapped(_ sender: Any) {
        updateDatePickerAndLabelAndRepetitionDateOf(date: .sun)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 14
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row % 2 == 1){
            return 130
        }
        else{
            return 44
        }
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
