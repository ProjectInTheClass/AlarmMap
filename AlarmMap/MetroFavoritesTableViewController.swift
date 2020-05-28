//
//  MetroFavoritesTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class MetroFavoritesTableViewController: UITableViewController {
    
    let floatingRefreshButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        floatingRefreshButton.addItem(title: "", image: UIImage(systemName: "arrow.clockwise"), action: {item in self.refresh()})
        floatingRefreshButton.display(inViewController: self)
        floatingRefreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingRefreshButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func refresh(){
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return metroStationList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationCell", for: indexPath) as! MetroStationCell
            
            let metroStation = metroStationList[indexPath.section]
            
            cell.lineLabel.text = metroStation.line
            cell.StationNameLabel.text = metroStation.name
            cell.directionLabel.text = metroStation.direction
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainsCell", for: indexPath) as! TrainsCell
            
            let trainList = metroStationList[indexPath.section].trainList
            
            cell.firstTrainRemainingTimeLabel.text = trainList[0].timeRemaining
            cell.firstTrainCurrentStationLabel.text = trainList[0].currentStation
            cell.firstTrainTerminalStationLabel.text = trainList[0].terminalStation
            
            cell.secondTrainRemainingTimeLabel.text = trainList[1].timeRemaining
            cell.secondTrainCurrentStationLabel.text = trainList[1].currentStation
            cell.secondTrainTerminalStationLabel.text = trainList[1].terminalStation
            
            cell.thirdTrainRemainingTimeLabel.text = trainList[2].timeRemaining
            cell.thirdTrainCurrentStationLabel.text = trainList[2].currentStation
            cell.thirdTrainTerminalStationLabel.text = trainList[2].terminalStation
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 31
        }
        else {
            return 99
        }
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
