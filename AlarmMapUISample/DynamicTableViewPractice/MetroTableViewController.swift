//
//  MetroTableViewController.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class MetroTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stationList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroTableViewCell", for: indexPath) as! MetroTableViewCell

        cell.lineLabel.text = stationList[indexPath.row].line
        cell.stationNameLabel.text = stationList[indexPath.row].name
        cell.directionLabel.text = stationList[indexPath.row].direction
        
        cell.lineLabel.backgroundColor = lineColor(line: stationList[indexPath.row].line)
        
        cell.firstTrainStackView.backgroundColor =
            lineColor(line: stationList[indexPath.row].line)
        
        cell.secondTrainStackView.backgroundColor =
            lineColor(line: stationList[indexPath.row].line)
        
        cell.thirdTrainStackView.backgroundColor =
        lineColor(line: stationList[indexPath.row].line)
        
        cell.fourthTrainStackView.backgroundColor =
        lineColor(line: stationList[indexPath.row].line)
        
        cell.timeRemainingFirstTrainLabel.text = stationList[indexPath.row].trainList[0].timeRemaining
        cell.currentStationFirstTrainLabel.text =
            stationList[indexPath.row].trainList[0].currentStation
        cell.terminalStationFirstTrainLabel.text =
            stationList[indexPath.row].trainList[0].terminalStation
        
        cell.timeRemainingSecondTrainLabel.text = stationList[indexPath.row].trainList[1].timeRemaining
        cell.currentStationSecondTrainLabel.text =
            stationList[indexPath.row].trainList[1].currentStation
        cell.terminalStationSecondTrainLabel.text =
            stationList[indexPath.row].trainList[1].terminalStation
        
        cell.timeRemainingThirdTrainLabel.text = stationList[indexPath.row].trainList[2].timeRemaining
        cell.currentStationThirdTrainLabel.text =
            stationList[indexPath.row].trainList[2].currentStation
        cell.terminalStationThirdTrainLabel.text =
            stationList[indexPath.row].trainList[2].terminalStation
        
        cell.timeRemainingFourthTrainLabel.text = stationList[indexPath.row].trainList[3].timeRemaining
        cell.currentStationFourthTrainLabel.text =
            stationList[indexPath.row].trainList[3].currentStation
        cell.terminalStationFourthTrainLabel.text =
            stationList[indexPath.row].trainList[3].terminalStation

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MetroTableViewCell
        cell.stacViewList[0].backgroundColor = UIColor.black
        
    }
    

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
