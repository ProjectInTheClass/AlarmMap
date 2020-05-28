//
//  RouteTableViewController.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class RouteListTableViewController: UITableViewController {
    
    let floatingAdditionButton = JJFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        floatingAdditionButton.addItem(title: "", image: UIImage(systemName: "plus"), action: {item in self.routeAdditionButtonTapped(item)})
        floatingAdditionButton.display(inViewController: self)
        floatingAdditionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingAdditionButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func routeAdditionButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "routeAdditionSegue", sender: sender)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return routeCategoryList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routeCategoryList[section].routeInfoList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "routeSettingSegue") {
            let routeSettingTableViewController = segue.destination as! RouteSettingTableViewController
            
            let selectedCell = tableView.indexPathForSelectedRow
            
            routeSettingTableViewController.category =
                selectedCell!.section == 0 ? .routine : .favorites
            routeSettingTableViewController.routeInfoNumber = selectedCell!.row
            
            routeSettingTableViewController.isNewRouteInfo = false
        }
        else if(segue.identifier == "routeAdditionSegue"){
            let routeSettingTableViewController = segue.destination as! RouteSettingTableViewController
            
            routeSettingTableViewController.isNewRouteInfo = true
        }
        else { //routeInformationSegue
            
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell1", for: indexPath) as! RouteListCell1
            
            cell.routeTitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].title
            cell.routeSubtitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle
            
            cell.routeAlarmSwitch.isOn = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].routeAlarmIsOn
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell2", for: indexPath) as! RouteListCell2
            
            cell.routeTitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].title
            cell.routeSubtitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return routeCategoryList[section].title
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            routeCategoryList[indexPath.section].routeInfoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
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
