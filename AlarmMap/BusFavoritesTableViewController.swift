//
//  BusFavoritesTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusFavoritesTableViewController: UITableViewController {
    
    var remainingTimeLabelList = [[UILabel]]()
    var currentLocationLabelList = [UILabel]()
    
    var busUpdateTimer:Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        busUpdateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(busUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func busUpdate(){
        var busStopIndex = 0
        var busIndex = 0
        var bus:Bus
        
        for _ in 0..<busStopList.count {
            for _ in 0..<busStopList[busStopIndex].busList.count{
                bus = busStopList[busStopIndex].busList[busIndex]
                bus.decreaseRemainingTime()
                
                remainingTimeLabelList[busStopIndex][busIndex].text = bus.firstBusRemainingTimeToString()
                remainingTimeLabelList[busStopIndex][busIndex+1].text = bus.secondBusRemainingTimeToString()
                
                busIndex += 1
            }
            busStopIndex += 1
            busIndex = 0
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return busStopList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return busStopList[section].busList.count + 1
        //bus stop cell + bus cells
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){ //bus stop cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath) as! BusStopCell
            
            cell.busStopNameLabel.text = busStopList[indexPath.section].name
            cell.busStopDirectionLabel.text = busStopList[indexPath.section].direction
            
            return cell
        }
        else{ //bus cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath) as! BusCell
            
            let bus = busStopList[indexPath.section].busList[indexPath.row - 1]
            
            cell.busNumberLabel.text = bus.busNumber
            
            cell.firstBusRemainingTimeLabel.text = bus.firstBusRemainingTimeToString()
            cell.firstBusCurrentLocationLabel.text = bus.firstBusCurrentLocation
            
            cell.secondBusRemainingTimeLabel.text = bus.secondBusRemainingTimeToString()
            cell.secondBusCurrentLocationLabel.text = bus.secondBusCurrentLocation
            
            remainingTimeLabelList.append([UILabel]())
            remainingTimeLabelList[indexPath.section].append(cell.firstBusRemainingTimeLabel)
            remainingTimeLabelList[indexPath.section].append(cell.secondBusRemainingTimeLabel)
            
            currentLocationLabelList.append(cell.firstBusCurrentLocationLabel)
            currentLocationLabelList.append(cell.secondBusCurrentLocationLabel)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == busStopList.count - 1){
            return 150
        }
        else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
