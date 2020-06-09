//
//  BusListSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/04.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusListSettingTableViewController: UITableViewController {
    
    var busStop:BusStop? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBusList(arsId: busStop!.arsId!, myBusStop: busStop!, busListSettingTV: self.tableView)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let addButton = sender as! UIButton
        addButton.isSelected = !addButton.isSelected
        
        let busListCell = addButton.superview?.superview?.superview as! BusListCell
        
        if(addButton.isSelected){
            busStop!.userSelectedBusList!.append(busStop!.busList![busListCell.busIndex])
        }
        else{
            let busNumber = busStop!.busList![busListCell.busIndex].busNumber
            for (index,bus) in busStop!.userSelectedBusList!.enumerated() {
                if(bus.busNumber == busNumber){
                    busStop!.userSelectedBusList!.remove(at: index)
                    break
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return busStop!.busList!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusListCell", for: indexPath) as! BusListCell
        
        cell.busNumberLabel.text = busStop!.busList![indexPath.row].busNumber
        
        cell.busIndex = indexPath.row
        cell.addButton.isSelected = false
        
        let busNumber = busStop!.busList![indexPath.row].busNumber
        for bus in busStop!.userSelectedBusList! {
            if(bus.busNumber == busNumber){
                cell.addButton.isSelected = true
                break
            }
        }
        
        return cell
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
